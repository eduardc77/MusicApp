//
//  TopImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct MediaPreviewHeader: View {
    let videoAssetUrl: URL?
    let imagePath: String?
    
    init(videoAssetUrl: URL? = nil, imagePath: String? = nil) {
        self.videoAssetUrl = videoAssetUrl
        self.imagePath = imagePath
    }
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -320 {
                Group {
                    if let videoAssetUrl = videoAssetUrl {
                        VideoHeaderView(videoAssetUrl: videoAssetUrl)
                    } else {
                        MediaImageView(imagePath: imagePath?.resizedPath(size: 600), contentMode: .fill)
                    }
                }
                .offset(y: offsetY(proxy: proxy))
                .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
            }
        }
        .frame(height: 320)
        
    }
}

private extension MediaPreviewHeader {
    func offsetY(proxy: GeometryProxy) -> CGFloat {
        -proxy.frame(in: .global).minY
    }
    
    func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + 320 : 320
    }
}


