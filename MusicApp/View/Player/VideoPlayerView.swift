//
//  VideoPlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @State private var autoReplay = true
    @State private var mute = false
    @State private var play = true
    @State var expand = false
    @State var isPlaying: Bool = false
    @State var showControls = false
    @State var trackTimePosition = 1
    @State var trackDuration = 1
    @State var player: AVPlayer
    
    var sizeType: SizeType
    
    init(url: URL, sizeType: SizeType = .defaultSize) {
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        
        self.sizeType = sizeType
    }
    
    var body: some View {
        VideoPlayer(player: $player)
            .frame(width: sizeType.size.width, height: sizeType.size.height)
        
            .onTapGesture {
                expand = true
            }
        
            .onAppear {
                togglePlayState()
                
                trackDuration = getDurationSeconds()
            }
        
    }
    
    func togglePlayState() {
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func getProgressRate() -> Int {
        return Int(player.currentTime().seconds)
    }
    
    func getDurationSeconds() -> Int {
        guard let durationInSeconds = player.currentItem?.asset.duration.seconds else { return 0 }
        
        return Int(durationInSeconds)
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {}
}

