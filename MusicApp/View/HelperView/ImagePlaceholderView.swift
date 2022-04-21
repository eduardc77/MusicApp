//
//  ImagePlaceholderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
    var image: Image?
    var size: (width: CGFloat?, height: CGFloat?) = (width: Metric.searchResultImageSize, height: Metric.searchResultImageSize)
    var cornerRadius: CGFloat = 6
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
                    .shadow(radius: 2, x: 0, y: 2)
            } else {
            Rectangle()
                .fill(Color.secondary.opacity(0.6))
                .frame(width: size.width, height: size.height)
                .cornerRadius(cornerRadius)
                .shadow(radius: 2, x: 0, y: 2)
            
            Image(systemName: "music.note")
                .foregroundColor(Color.secondary)
            }
        }
    }
}

struct MediaImageView_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageView()
    }
}
