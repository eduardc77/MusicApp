//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
   @Binding private var visibleSide: FlipViewSide
   var selected: Bool = false
   private let imagePath: String?
   private var artworkImage: UIImage?
   private var sizeType: SizeType
   private var cornerRadius: CGFloat
   private var shadowProminence: ShadowProminence
   private var contentMode: ContentMode
   
   init(imagePath: String? = nil, artworkImage: UIImage? = nil, sizeType: SizeType = .none, shadowProminence: ShadowProminence = .none, contentMode: ContentMode = .fit, visibleSide: Binding<FlipViewSide> = .constant(.front), selected: Bool = false) {
      _visibleSide = visibleSide
      self.selected = selected
      self.imagePath = imagePath
      self.artworkImage = artworkImage
      self.sizeType = sizeType
      self.shadowProminence = shadowProminence
      self.contentMode = contentMode
      self.cornerRadius = sizeType.cornerRadius
   }
   
   var body: some View {
      FlipView(visibleSide: visibleSide) {
         Group {
            if let artworkImage = artworkImage {
               Image(uiImage: artworkImage).resizable()
            } else if let imagePath = imagePath, let url = URL(string: imagePath) {
               AsyncImageView(url: url, sizeType: sizeType)
            } else {
               DefaultImage(sizeType: sizeType)
            }
         }
         .aspectRatio(contentMode: contentMode)
         .frame(width: sizeType.size.width, height: sizeType.size.height)
         
         .overlay {
            if selected {
               ZStack {
                  Color.gray.opacity(0.6)
                  
                  NowPlayingEqualizerBars(color: .white)
                     .frame(width: 16, height: 8)
               }
            }
         }
         .clipShape(sizeType == .artistRow ? RoundedRectangle(cornerRadius: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, style: .continuous) : RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
         .overlay { RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.secondary, lineWidth: 0.08) }
      } back: {
         DefaultImage(sizeType: sizeType)
            .frame(width: sizeType.size.width, height: sizeType.size.height)
            .clipShape(sizeType == .artistRow ? RoundedRectangle(cornerRadius: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, style: .continuous) : RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay { RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.secondary, lineWidth: 0.08) }
      }
      
      .shadow(radius: shadowProminence.shadow.radius, x: shadowProminence.shadow.xPosition, y: shadowProminence.shadow.yPosition)
      .animation(.flipCard, value: visibleSide == .back)
   }
}

// MARK: - Types

extension MediaImageView {
   enum ShadowProminence {
      case none
      case mild
      case full
      
      var shadow: (radius: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
         switch self {
         case .none:
            return (radius: 0, xPosition: 0, yPosition: 0)
         case .mild:
            return (radius: 2, xPosition: 0, yPosition: 0)
         case .full:
            return (radius: 16, xPosition: 3, yPosition: 3)
         }
      }
   }
}


// MARK: - Previews

struct MediaImageView_Previews: PreviewProvider {
   struct MediaImageViewExample: View {
      @State private var visibleSide = FlipViewSide.front
      
      var body: some View {
         ZStack {
            Color.indigo
            
            MediaImageView(artworkImage: UIImage(named: "p0"), sizeType: .albumDetail, shadowProminence: .full, visibleSide: $visibleSide)
               .onTapGesture {
                  visibleSide.toggle()
               }
         }
         .ignoresSafeArea()
      }
   }
   static var previews: some View {
      MediaImageViewExample()
   }
}

