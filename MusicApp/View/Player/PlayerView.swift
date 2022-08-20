//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    @State private var offset: CGFloat = 0
    @State private var visibleSide = FlipViewSide.front
    @State private var playing: Bool = false
    
    static let timer = Timer.publish(every: 0.6, tolerance: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if playerObservableObject.expand {
                Capsule()
                    .fill(Color.lightGrayColor2)
                    .frame(width: Metric.capsuleWidth, height: Metric.capsuleHeight)
            }
            
            HStack {
                if playerObservableObject.playerType == .video {
                    playerObservableObject.videoPlayer
                        .frame(width: playerObservableObject.expand ? SizeType.largeHighlight.size.width : SizeType.smallPlayerVideo.size.width, height: playerObservableObject.expand ? SizeType.largeHighlight.size.height : SizeType.smallPlayerVideo.size.height)
                        .cornerRadius(playerObservableObject.expand ? 0 : Metric.defaultCornerRadius)
                } else {
                    MediaImageView(imagePath: playerObservableObject.nowPlayingItem.media.artworkPath.resizedPath(size: 600), artworkImage: playerObservableObject.nowPlayingItem.media.artwork, sizeType: playerObservableObject.expand ? .largePlayerArtwork : .trackRowItem, cornerRadius: playerObservableObject.expand ? 10 : Metric.defaultCornerRadius, shadowProminence: playerObservableObject.expand ? .full : .none, visibleSide: $visibleSide)
                        .scaleEffect((playerObservableObject.playbackState == .playing && playerObservableObject.expand) ? 1.33 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3), value: playerObservableObject.playbackState)
                    
                        .onTapGesture {
                            guard playerObservableObject.expand else { return }
                            visibleSide.toggle()
                        }
                }
                
                if !playerObservableObject.expand {
                    Group {
                        Text(playerObservableObject.nowPlayingItem.media.trackName)
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                playerObservableObject.playbackState == .playing ? playerObservableObject.audioPlayer.pause() : playerObservableObject.audioPlayer.play()
                            },
                                   label: {
                                playerObservableObject.playbackState == .playing ?
                                Image(systemName: "pause.fill")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                                :
                                Image(systemName: "play.fill")
                                    .font(.title)
                                    .foregroundColor(.primary)
                            }
                            )
                            .padding(.trailing)
                            
                            Button(action: {
                                playerObservableObject.audioPlayer.skipToNextItem()
                            },
                                   label: {
                                Image(systemName: "forward.fill")
                                    .font(.title2)
                                    .foregroundColor(!playerObservableObject.nowPlayingItem.media.name.isEmpty ? .primary : .secondary)
                            }
                            )
                        }
                    }
                }
            }
            .padding()
            .frame(height: playerObservableObject.expand ? UIScreen.main.bounds.height / 2.2 :  Metric.playerHeight)
            
            if playerObservableObject.expand {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            MarqueeText(text: playerObservableObject.nowPlayingItem.media.mediaResponse.name != nil ? playerObservableObject.nowPlayingItem.media.name : "Not Playing", explicitness: playerObservableObject.nowPlayingItem.media.trackExplicitness)
                            
                            MarqueeText(text: playerObservableObject.nowPlayingItem.media.artistName, color: playerObservableObject.playerType == .audio ? .lightGrayColor : .accentColor, font: UIFont.systemFont(ofSize: 20))
                        }
                        
                        Spacer()
                        
                        if playerObservableObject.playerType == .audio {
                            Button(action: { }) {
                                Image(systemName: "ellipsis.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.white, Color.lightGrayColor3)
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 6)
                        } else {
                            Button(action: { }) {
                                Image(systemName: "ellipsis.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(Color.accentColor, Color.accentColor.opacity(0.2))
                            }
                            .padding(.trailing, 30)
                            .padding(.leading, 6)
                        }
                    }
                    
                    VStack {
                        switch playerObservableObject.playerType {
                        case .audio:
                            TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: playerObservableObject.audioPlayer.nowPlayingItem?.playbackDuration.toInt ?? 1, trackTimePosition: $playerObservableObject.progressRate, player: playerObservableObject.audioPlayer)
                            
                                .onReceive(PlayerView.timer) { _ in
                                    guard playerObservableObject.playerType == .audio else { return }
                                    playerObservableObject.progressRate = playerObservableObject.audioPlayer.currentPlaybackTime.toInt
                                }
                        case .video:
                            TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: playerObservableObject.videoPlayer.trackDuration, trackTimePosition: $playerObservableObject.videoPlayer.trackTimePosition, player: playerObservableObject.audioPlayer)
                        }    
                        PlayerControls(playerObservableObject: _playerObservableObject)
                        
                        VolumeView(playerType: playerObservableObject.playerType)
                    }
                    .padding(.horizontal)
                }
               
                .transition(.move(edge: .bottom))
                .frame(height: playerObservableObject.expand ? UIScreen.main.bounds.height / 2.8 : 0)
            }
        }
        .frame(maxHeight: playerObservableObject.expand ? .infinity : Metric.playerHeight)
        
        .background(
            Group {
                if playerObservableObject.expand {
                    if let artworkUIImage = playerObservableObject.nowPlayingItem.media.artwork, playerObservableObject.playerType == .audio {
                        LinearGradient(
                            gradient: Gradient(colors: [Color(artworkUIImage.firstAverageColor ?? .gray), Color(artworkUIImage.secondAverageColor ?? .gray)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    } else {
                        Color(.black)
                    }
                } else {
                    VStack(spacing: 0) {
                        BlurView()
                        Divider()
                    }
                }
            }
                .onTapGesture {
                    withAnimation(.spring()) {
                        playerObservableObject.expand = true
                    }
                }
        )
        
        .offset(y: offset)
        .offset(y: playerObservableObject.expand ? 0 : Metric.yOffset)
        .ignoresSafeArea()
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
            playerObservableObject.playbackState = playerObservableObject.audioPlayer.playbackState
            
            switch playerObservableObject.playbackState {
            case .playing:
                playing = true
            default:
                playing = false
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)){ _ in
            playerObservableObject.playerType = .audio
            guard let mediaItem = playerObservableObject.audioPlayer.nowPlayingItem else { return }
            playerObservableObject.progressRate = playerObservableObject.audioPlayer.currentPlaybackTime.toInt
            playerObservableObject.makeNowPlaying(media: mediaItem, playing: $playing)
        }
        
        .onAppear {
            playerObservableObject.initPlayerFromUserDefaults()
        }
    }
    
    // pull down Player
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 && playerObservableObject.expand {
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.98, blendDuration: 0.69)) {
            if value.translation.height > UIScreen.main.bounds.height / 12 {
                withAnimation(.spring()) {
                    playerObservableObject.expand = false
                }
                
            }
            offset = 0
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    struct PlayerViewExample: View {
        @Namespace var animation
        @State var expand: Bool = true
        
        var player = MPMusicPlayerController.applicationMusicPlayer
        
        var body: some View {
            VStack {
                Spacer()
                
                PlayerView()
            }
        }
    }
    
    static var previews: some View {
        PlayerViewExample()
            .environmentObject(PlayerObservableObject())
    }
}

