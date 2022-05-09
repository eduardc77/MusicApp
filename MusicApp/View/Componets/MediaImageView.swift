//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
    var image: Image?
    var size: Size
    var cornerRadius: CGFloat
    var prominentShadow: Bool
    var contentMode: ContentMode
    var foregroundColor: Color
    
    @Binding var visibleSide: FlipViewSide
    
    init(image: Image? = nil, size: Size = Size(), cornerRadius: CGFloat = 4, prominentShadow: Bool = false, contentMode: ContentMode = .fit, foregroundColor: Color = .secondary.opacity(0.1), visibleSide: Binding<FlipViewSide> = .constant(.front)) {
        self.image = image
        self.size = size
        self.cornerRadius = cornerRadius
        self.prominentShadow = prominentShadow
        self.contentMode = contentMode
        self.foregroundColor = foregroundColor
        
        _visibleSide = visibleSide
    }
    
    var body: some View {
        FlipView(visibleSide: visibleSide) {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
                    .shadow(radius: prominentShadow ? 16 : 2, x: prominentShadow ? -6 : 0, y: prominentShadow ? 6 : 2)
            } else {
                ZStack {
                    Rectangle()
                        .fill(foregroundColor)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(cornerRadius)
                    
                    Image("music.note")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.secondary.opacity(0.3))
                        .frame(width: (size.height ?? Metric.mediumImageSize) / 1.6, height: (size.height ?? Metric.mediumImageSize) / 1.6)
                }
            }
        } back: {
            ZStack {
                Rectangle()
                    .fill(foregroundColor)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
                
                Image("music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.secondary.opacity(0.3))
                    .frame(width: (size.height ?? Metric.mediumImageSize) / 1.6, height: (size.height ?? Metric.mediumImageSize) / 1.6)
            }
        }
        .contentShape(Rectangle())
        .animation(.flipCard, value: visibleSide)
    }
    
}

struct MediaImageView_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageView(image: Image("p0"), size: Size(width: 333, height: 333))
    }
}
