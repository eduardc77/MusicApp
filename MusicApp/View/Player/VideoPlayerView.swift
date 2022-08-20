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
    var player: AVPlayer
    private var sizeType: SizeType
    private var cornerRadius: CGFloat
    var videoAssetUrl: URL = URL(string: "https://www.apple.com/404")!
    
    
    init(videoAssetUrl: URL, sizeType: SizeType = .defaultSize, cornerRadius: CGFloat = Metric.defaultCornerRadius) {
        self.sizeType = sizeType
        self.cornerRadius = cornerRadius
        self.videoAssetUrl = videoAssetUrl
        
        let asset = AVAsset(url: videoAssetUrl)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .onChange(of: isPlaying) { newValue in
                togglePlayPause(newValue)
            }
            .onAppear {
                isPlaying = true
                trackDuration = getDurationSeconds()
            }
            .onDisappear {
                player.pause()
                isPlaying = false
            }
    }
    
    func playVideoAsset(url: URL) {
        let asset = AVAsset(url: videoAssetUrl)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
        
        isPlaying = true
        player.play()
    }
    
    func getProgressRate() -> Int {
        return Int(player.currentTime().seconds)
    }
    
    func getDurationSeconds() -> Int {
        guard let durationInSeconds = player.currentItem?.asset.duration.seconds else { return 0 }
        
        return Int(durationInSeconds)
    }
    
    private func togglePlayPause(_ newValue: Bool) {
        if newValue {
            player.pause()
            isPlaying = false
        }
        else {
            player.play()
            isPlaying = true
        }
    }
}
