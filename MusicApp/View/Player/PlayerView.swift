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
    @State var offset: CGFloat = 0
    @State private var visibleSide = FlipViewSide.front
    
    static let timer = Timer.publish(every: 0.6, tolerance: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.lightGrayColor)
                .frame(width: playerObservableObject.expand ? Metric.capsuleWidth : 0, height: playerObservableObject.expand ? Metric.capsuleHeight : 0)
                .opacity(playerObservableObject.expand ? 1 : 0)
                .offset(y: playerObservableObject.expand ? -12 : 0)
            
            VStack {
                // Mini Player
                HStack {
                    if playerObservableObject.expand { Spacer() }
                    if playerObservableObject.playerType == .video {
                        playerObservableObject.videoPlayer

                    } else {
                        MediaImageView(imagePath: playerObservableObject.nowPlayingItem?.artworkPath.resizedPath(size: 600), artworkImage: playerObservableObject.nowPlayingItem?.artwork, size: Size(width: playerObservableObject.expand ? Metric.largeMediaImageSize : Metric.playerSmallImageSize, height: playerObservableObject.expand ? Metric.largeMediaImageSize : Metric.playerSmallImageSize), cornerRadius: playerObservableObject.expand ? 10 : Metric.searchResultCornerRadius, shadowProminence: playerObservableObject.expand ? .full : .none, visibleSide: $visibleSide)
                            .scaleEffect((playerObservableObject.playbackState == .playing && playerObservableObject.expand) ? 1.33 : 1)
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3), value: playerObservableObject.playbackState)
                        
                            .onTapGesture {
                                visibleSide.toggle()
                            }
                    }
                    
                    if !playerObservableObject.expand {
                        Text(playerObservableObject.nowPlayingItem?.trackName ?? "Not Playing")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    
                    if !playerObservableObject.expand {
                        HStack {
                            Button(action: {
                                guard playerObservableObject.nowPlayingItem != nil else { return }
                                playerObservableObject.playbackState == .playing ? playerObservableObject.player.pause() : playerObservableObject.player.play()
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
                            
                            Button(action: {},
                                   label: {
                                Image(systemName: "forward.fill")
                                    .font(.title2)
                                    .foregroundColor(playerObservableObject.nowPlayingItem != nil ? .primary : .secondary)
                            }
                            )
                        }
                    }
                }
                .padding()
            }
            .frame(height: playerObservableObject.expand ? UIScreen.main.bounds.height / 2.2 :  Metric.playerHeight)
            
            if !playerObservableObject.expand { Spacer() }
            
            // Full Screen Player
            if playerObservableObject.expand {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(playerObservableObject.nowPlayingItem?.trackName ?? "Not Playing")
                                .font(.title2).bold()
                                .foregroundColor(.white.opacity(0.9))
                            Text(playerObservableObject.nowPlayingItem?.artistName ?? "")
                                .foregroundColor(.lightGrayColor)
                                .font(.title2)
                        }
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis.circle.fill")
                                .font(.title)
                                .foregroundStyle(.white, Color.lightGrayColor3)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        switch playerObservableObject.playerType {
                        case .audio:
                            TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: playerObservableObject.player.nowPlayingItem?.playbackDuration.toInt ?? playerObservableObject.noTrackTime, trackTimePosition: $playerObservableObject.progressRate, player: playerObservableObject.player)
                            
                                .onReceive(PlayerView.timer) { _ in
                                    guard playerObservableObject.playerType == .audio else { return }
                                    playerObservableObject.progressRate = playerObservableObject.player.currentPlaybackTime.toInt
                                }
                        case .video:
                            TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: playerObservableObject.videoPlayer.trackDuration, trackTimePosition: $playerObservableObject.videoPlayer.trackTimePosition, player: playerObservableObject.player)
                            
                                .onReceive(PlayerView.timer) { _ in
                                    guard playerObservableObject.playerType == .audio else { return }
                                    playerObservableObject.progressRate = playerObservableObject.player.currentPlaybackTime.toInt
                                }
                        }
                        
                        PlayerControls(playerObservableObject: _playerObservableObject)
                        
                        VolumeView()
                    }
                }
                .transition(.move(edge: .bottom))
                .frame(height: playerObservableObject.expand ? UIScreen.main.bounds.height / 2.8 : 0)
                .padding(.horizontal)
            }
        }
        .frame(maxHeight: playerObservableObject.expand ? .infinity : Metric.playerHeight)
        
        .background(
            VStack(spacing: 0) {
                if playerObservableObject.expand {
                    if let artworkUIImage = playerObservableObject.nowPlayingItem?.artwork {
                        ZStack {
                            BlurView()
                            
                            LinearGradient(
                                gradient: Gradient(colors: [Color(artworkUIImage.firstAverageColor ?? .gray), Color(artworkUIImage.secondAverageColor ?? .gray)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        }
                    } else {
                        Color(.black)
                    }
                } else {
                    BlurView()
                    Divider()
                }
            }
                .onTapGesture {
                    withAnimation(.spring()) {
                        playerObservableObject.expand = true
                    }
                }
        )
        .cornerRadius(playerObservableObject.expand ? (UIDevice.current.hasTopNotch ? 36 : 0) : 0)
        .offset(y: playerObservableObject.expand ? 0 : Metric.yOffset)
        .offset(y: offset)
        
        .gesture(DragGesture()
            .onChanged(onChanged(value:))
            .onEnded(onEnded(value:)))
        
        .ignoresSafeArea()
        
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
            playerObservableObject.playbackState = playerObservableObject.player.playbackState
        }
        
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)){ _ in
            playerObservableObject.playerType = .audio
            guard let mediaItem = playerObservableObject.player.nowPlayingItem else {
                playerObservableObject.makeNowPlaying()
                return
            }
            playerObservableObject.progressRate = playerObservableObject.player.currentPlaybackTime.toInt
            playerObservableObject.makeNowPlaying(media: mediaItem)
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
                playerObservableObject.expand = false
            }
            offset = 0
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    struct PlayerViewExample: View {
//        private var player = MPMusicPlayerController.applicationMusicPlayer
//        @Namespace var animation
//        @State var expand: Bool = true
//
//        var body: some View {
//            VStack {
//                if !expand {
//                    Button {
//                        expand.toggle()
//                    } label: {
//                        Text("Expand View")
//                    }
//                    Spacer()
//                }
//                PlayerView(animation: animation)
//            }
//        }
//    }
//    static var previews: some View {
//        PlayerViewExample()
//            .previewDevice("iPhone 13 Pro Max")
//    }
//}
//
