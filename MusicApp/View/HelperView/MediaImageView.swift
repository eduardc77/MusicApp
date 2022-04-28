//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
    var image: Image?
    var size = Size()
    var cornerRadius: CGFloat = 4
    var isLargeArtworkSize: Bool = false
    var contentMode: ContentMode = .fit
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: size.width, height: size.height)
                .cornerRadius(cornerRadius)
                .shadow(radius: isLargeArtworkSize ? 16 : 2, x: isLargeArtworkSize ? -6 : 0, y: isLargeArtworkSize ? 6 : 2)
        } else {
            ZStack {
                Rectangle()
                    .fill(Color.secondary.opacity(0.1))
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
                
                Image("music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.secondary.opacity(0.3))
                    .frame(width: (size.height ?? Metric.mediumImageSize) / 1.6, height: (size.height ?? Metric.mediumImageSize) / 1.6)
            }
        }
    }
}

struct MediaImageView_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageView(image: Image("p"), size: Size(width: 333, height: 333))
            .preferredColorScheme(.dark)
    }
}
