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
    
    init(player: MPMusicPlayerController, expand: Binding<Bool>, animation: Namespace.ID) {
        _playerObservableObject = StateObject(wrappedValue: PlayerObservableObject(player: player))
        _expand = expand
        self.animation = animation
    }
    
    var body: some View {
        VStack {
            
            Capsule()
                .fill(Color.secondary.opacity(0.5))
                .frame(width: expand ? Metric.capsuleWidth : 0, height: expand ? Metric.capsuleHeight : 0)
                .opacity(expand ? 1 : 0)
            
            VStack {
                // Mini Player
                HStack {
                    if expand { Spacer() }
                   
                    if let artwork = playerObservableObject.nowPlayingItem?.artwork {
                        MediaImageView(image: Image(uiImage: artwork), size: Size(width: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize, height: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize), cornerRadius: expand ? 10 : Metric.searchResultCornerRadius)
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
                }.padding()
            }
            .frame(height: expand ? UIScreen.main.bounds.height / 2.2 :  Metric.playerHeight)
            
            // Full Screen Player
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(playerObservableObject.nowPlayingItem?.trackName ?? "Not Playing")
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                        Text(playerObservableObject.nowPlayingItem?.artistName ?? "")
                            .foregroundColor(.secondary)
                            .font(.title3)
                    }
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white, .gray.opacity(0.3))
                    }
                }
                .padding(.horizontal)
               
                TimeSliderView(songTime: playerObservableObject.player.nowPlayingItem?.playbackDuration.inSeconds ?? Int(playerObservableObject.noTrackTime), songTimePosition: $playerObservableObject.progressRate)
    
                PlayerButtonsView(playerObservableObject: playerObservableObject)
                Spacer()
                VolumeView()
                Spacer()
            }
            
            .frame(height: expand ? UIScreen.main.bounds.height / 2.8 : 0)
            .opacity(expand ? 1 : 0)
            .padding(.horizontal)
        }
        .frame(maxHeight: expand ? .infinity : Metric.playerHeight)
        .background(
            VStack(spacing: 0) {
                if expand {
                    ZStack {
                        if let artwork = playerObservableObject.nowPlayingItem?.artwork {
                            BlurView()
                            LinearGradient(
                                gradient: Gradient(colors: [Color(artwork.firstAverageColor()), Color(artwork.secondAverageColor())]),
                                startPoint: .top,
                                endPoint: .bottom)
                        } else {
                            Color(.gray)
                        }
//                        if let artworkUrl = playerObservableObject.nowPlayingItem?.artworkUrl100, let mediaArtwork = UIImage(contentsOfFile: artworkUrl.path) {
//                            BlurView()
//                            LinearGradient(
//                                gradient: Gradient(colors: [Color(mediaArtwork.firstAverageColor()).opacity(0.8), Color(mediaArtwork.secondAverageColor()).opacity(0.8)]),
//                                startPoint: .topTrailing,
//                                endPoint: .bottomLeading)
//                        } else {
//                            Color(.gray)
//                        }
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
            playerObservableObject.progressRate = playerObservableObject.player.currentPlaybackTime.inSeconds
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
            .previewDevice("iPod touch (7th generation)")
    }
}

extension UIImage {
    func firstAverageColor() -> UIColor {
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        // Create 1x1 context that interpolates pixels when drawing to it.
        let context = CGContext(data: &bitmap, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        let inputImage = cgImage ?? CIContext().createCGImage(ciImage!, from: ciImage!.extent)
        
        // Render to bitmap.
        context.draw(inputImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        // Compute result.
        let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: 1)
        return result
    }
    
    func secondAverageColor() -> UIColor {
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        let context = CIContext()
        let inputImage: CIImage = ciImage ?? CoreImage.CIImage(cgImage: cgImage!)
        let extent = inputImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
        let outputImage = filter.outputImage!
        let outputExtent = outputImage.extent
        assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
        
        // Render to bitmap.
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        
        // Compute result.
        let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: 1)
        return result
    }
    
}
