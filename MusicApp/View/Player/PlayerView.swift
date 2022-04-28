//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
    @StateObject private var playerObservableObject: PlayerObservableObject
    @Binding var expand: Bool
    @State var songTimePosition: Double = 0
    @State var offset: CGFloat = 0
    
    var animation: Namespace.ID
    static let timer = Timer.publish(every: 0.5, tolerance: nil, on: .main, in: .common).autoconnect()
    
    init(player: MPMusicPlayerController, expand: Binding<Bool>, animation: Namespace.ID) {
        _playerObservableObject = StateObject(wrappedValue: PlayerObservableObject(player: player))
        _expand = expand
        self.animation = animation
    }
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.lightGrayColor)
                .frame(width: expand ? Metric.capsuleWidth : 0, height: expand ? Metric.capsuleHeight : 0)
                .opacity(expand ? 1 : 0)
                .offset(y: expand ? -12 : 0)
            
            VStack {
                // Mini Player
                HStack {
                    if expand { Spacer() }
                    
                    if let artwork = playerObservableObject.nowPlayingItem?.artwork {
                        MediaImageView(image: artwork, size: Size(width: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize, height: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize), cornerRadius: expand ? 10 : Metric.searchResultCornerRadius, isLargeArtworkSize: expand ? true : false)
                            .scaleEffect((playerObservableObject.playbackState == .playing && expand) ? 1.33 : 1)
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3), value: playerObservableObject.playbackState)
                    } else {
                        // Or PlaceholderImage
                        MediaImageView(size: Size(width: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize, height: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize), cornerRadius: expand ? 10 : Metric.searchResultCornerRadius)
                            .scaleEffect((playerObservableObject.playbackState == .playing && expand) ? 1.33 : 1)
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3), value: playerObservableObject.playbackState)
                    }
                    
                    if !expand {
                        Text(playerObservableObject.nowPlayingItem?.trackName ?? "Not Playing")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    
                    if !expand {
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
                                    .foregroundColor(.secondary)
                            }
                            )
                        }
                    }
                }
                .padding()
            }
            .frame(height: expand ? UIScreen.main.bounds.height / 2.2 :  Metric.playerHeight)
            
            if !expand { Spacer() }
            
            // Full Screen Player
            if expand {
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
                        TimeSliderView(playerObservableObject: playerObservableObject, songTime: playerObservableObject.player.nowPlayingItem?.playbackDuration.toInt ?? Int(playerObservableObject.noTrackTime), songTimePosition: $playerObservableObject.progressRate, player: playerObservableObject.player)
                        
                            .onReceive(PlayerView.timer) { _ in
                                playerObservableObject.progressRate = playerObservableObject.player.currentPlaybackTime.toInt
                            }
                        
                        PlayerButtonsView(playerObservableObject: playerObservableObject)
                        
                        VolumeView()
                    }
                }
                .transition(.move(edge: .bottom))
                .frame(height: expand ? UIScreen.main.bounds.height / 2.8 : 0)
                .padding(.horizontal)
            }
            
        }
        .frame(maxHeight: expand ? .infinity : Metric.playerHeight)
        .background(
            VStack(spacing: 0) {
                if expand {
                    ZStack {
                        if let artworkUrl = playerObservableObject.nowPlayingItem?.artworkUrl100, let artworkData = try? Data(contentsOf: artworkUrl) {
                            BlurView()
                            LinearGradient(
                                gradient: Gradient(colors: [Color(UIImage(data: artworkData)?.firstAverageColor() ?? .gray), Color(UIImage(data: artworkData)?.firstAverageColor() ?? .gray)]),
                                startPoint: .top,
                                endPoint: .bottom)
                        } else {
                            Color(.gray)
                        }
                    }
                } else {
                    BlurView()
                    Divider()
                }
            }
                .onTapGesture {
                    withAnimation(.spring()) {
                        expand = true
                    }
                }
        )
        .cornerRadius(expand ? (UIDevice.current.hasTopNotch ? 36 : 0) : 0)
        .offset(y: expand ? 0 : Metric.yOffset)
        .offset(y: offset)
        .gesture(DragGesture()
            .onChanged(onChanged(value:))
            .onEnded(onEnded(value:)))
        
        .ignoresSafeArea()
        
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
            playerObservableObject.playbackState = MPMusicPlayerController.applicationMusicPlayer.playbackState
        }
        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)){ _ in
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
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.98, blendDuration: 0.69)) {
            if value.translation.height > UIScreen.main.bounds.height / 12 {
                expand = false
            }
            offset = 0
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    struct PlayerViewExample: View {
        private var player = MPMusicPlayerController.applicationMusicPlayer
        @Namespace var animation
        @State var expand: Bool = true
        
        var body: some View {
            VStack {
                if !expand {
                    Button {
                        expand.toggle()
                    } label: {
                        Text("Expand View")
                    }
                    Spacer()
                }
                PlayerView(player: player, expand: $expand, animation: animation)
            }
        }
    }
    static var previews: some View {
        PlayerViewExample()
            .previewDevice("iPhone 13 Pro Max")
    }
}

