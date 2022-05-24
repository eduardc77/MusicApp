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
    @State var isPlaying = false
    @State var showControls = false
    @State var trackTimePosition = 1
    @State var trackDuration = 1
    @State var player: AVPlayer
    
    init(url: URL) {
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
    }
    
    var body: some View {
        VideoPlayer(player: $player)
            .onTapGesture {
                expand = true
            }
            .onChange(of: isPlaying) { newValue in
            if newValue == true {
                player.play()
                isPlaying = true
            }
            else {
                player.pause()
                isPlaying = false
            }
        }
        .onAppear {
            player.play()
            isPlaying = true
            
            trackDuration = getDurationSeconds()
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
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {}
    
    
}

