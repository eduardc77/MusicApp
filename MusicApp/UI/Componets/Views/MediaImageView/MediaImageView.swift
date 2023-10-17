//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView<Content: View>: View {
   private var sizeType: SizeType
   private var cornerRadius: CGFloat
   private var shadowProminence: ShadowProminence
   let content: (() -> Content)
   
   init(
      sizeType: SizeType = .none,
      shadowProminence: ShadowProminence = .none,
      @ViewBuilder _ content: @escaping () -> Content
   ) {
      self.sizeType = sizeType
      self.cornerRadius = sizeType.cornerRadius
      self.shadowProminence = shadowProminence
      self.content = content
   }
   
   var body: some View {
      content()
         .frame(width: sizeType.size.width, height: sizeType.size.height)
         .clipShape(sizeType == .artistRow ? RoundedRectangle(cornerRadius: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, style: .continuous) : RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
      
         .if(shadowProminence != .none, transform: { view in
            view.background {
               RoundedRectangle(cornerRadius: cornerRadius).shadow(radius: shadowProminence.shadow.radius, x: shadowProminence.shadow.xPosition, y: shadowProminence.shadow.yPosition)
            }
         })
         .overlay { RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(Color.secondary.opacity(0.2), lineWidth: 0.8) }
   }
}
