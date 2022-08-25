//
//  TopImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct MediaPreviewHeader: View {
    let imagePath: String
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -Metric.mediaPreviewHeaderHeight {
                MediaImageView(imagePath: imagePath.resizedPath(size: 600), contentMode: .fill)
                    .offset(y: offsetY(proxy: proxy))
                    .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
            }
        }
        .frame(height: Metric.mediaPreviewHeaderHeight)
    }
}

private extension MediaPreviewHeader {
    func offsetY(proxy: GeometryProxy) -> CGFloat {
        -proxy.frame(in: .global).minY
    }
    
    func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + Metric.mediaPreviewHeaderHeight : Metric.mediaPreviewHeaderHeight
    }
}


