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
                .font(.system(size: size.height ?? Metric.searchResultImageSize))
            }
        }
    }
}

struct MediaImageView_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageView()
    }
}

struct Size {
    var width: CGFloat? = Metric.searchResultImageSize
    var height: CGFloat? = Metric.searchResultImageSize
}
