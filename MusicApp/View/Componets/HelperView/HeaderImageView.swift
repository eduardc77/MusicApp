//
//  TopImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI
import AVKit

struct HeaderImageView: View {
    let imagePath: String
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -320 {
                MediaImageView(imagePath: imagePath.resizedPath(size: 600), contentMode: .fill)
                    .offset(y: offsetY(proxy: proxy))
                    .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
            }
        }
        .frame(height: 320)
        
    }
}

private extension HeaderImageView {
    func offsetY(proxy: GeometryProxy) -> CGFloat {
        -proxy.frame(in: .global).minY
    }
    
    func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + 320 : 320
    }
}


struct VideoHeaderImageView: View {
    let videoAssetUrl: URL
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -320 {
                VideoHeaderView(videoAssetUrl: videoAssetUrl)
                    .offset(y: offsetY(proxy: proxy))
                    .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
            }
        }
        .frame(height: 320)
        .ignoresSafeArea()
    }
}

private extension VideoHeaderImageView {
    func offsetY(proxy: GeometryProxy) -> CGFloat {
        -proxy.frame(in: .global).minY
    }
    
    func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + 320 : 320
    }
}


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
    private var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(videoAssetUrl: URL) {
        super.init(frame: .zero)
        
        let asset = AVAsset(url: videoAssetUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        player.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
       
        
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        player.play()
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
