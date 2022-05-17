//
//  VideoHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 17.05.2022.
//

import SwiftUI
import AVKit

struct VideoHeaderView: UIViewRepresentable {
    let videoAssetUrls: [URL]
    
    init(videoAssetUrls: [URL]) {
        self.videoAssetUrls = videoAssetUrls
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoHeaderView>) { }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(videoAssetUrls: videoAssetUrls)
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private let player = AVQueuePlayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(videoAssetUrls: [URL]) {
        super.init(frame: .zero)
        
        
        player.rate = 1.6
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        playerLayer.drawsAsynchronously = true
        
        let assets = videoAssetUrls.map { AVURLAsset(url: $0) }
        assets.forEach { player.insert(AVPlayerItem(asset: $0), after: nil) }
        
        player.actionAtItemEnd = .advance
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    @objc
        func playerItemDidReachEnd(notification: Notification) {
            player.seek(to: CMTime.zero)
        }
}
