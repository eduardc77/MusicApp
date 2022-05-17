//
//  VideoHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 17.05.2022.
//

import SwiftUI
import AVKit

struct VideoHeaderView: UIViewRepresentable {
    let videoAssetUrl: URL
    
    init(videoAssetUrl: URL) {
        self.videoAssetUrl = videoAssetUrl
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoHeaderView>) { }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(videoAssetUrl: videoAssetUrl)
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(videoAssetUrls: [URL]) {
        super.init(frame: .zero)
        
        let asset = AVAsset(url: videoAssetUrls)
        let item = AVPlayerItem(asset: asset)
        
        let player = AVQueuePlayer(items: [item])
        player.rate = 1.6
        
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        // Setup looping
        player.actionAtItemEnd = .none
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
            playerLayer.player?.seek(to: CMTime.zero)
        }
}
