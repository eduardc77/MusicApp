//
//  ArtistPageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct ArtistPageView: View {
    let imagePath: String
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.frame(in: .global).minY > -300 {
                MediaImageView(imagePath: imagePath.resizedPath(size: 600))
                    .scaledToFill()
                    .offset(y: offsetY(proxy: proxy))
                    .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
            }
        }
        .frame(height: 300)
    }
}

private extension ArtistPageView {
    func offsetY(proxy: GeometryProxy) -> CGFloat {
        -proxy.frame(in: .global).minY
    }
    
    func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + 400 : 400
    }
}
