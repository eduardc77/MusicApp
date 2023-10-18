//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @Binding private var visibleSide: FlipViewSide
   private var selected: Bool = false
   private let imagePath: String?
   private var artworkImage: UIImage?
   private var sizeType: SizeType
   private var cornerRadius: CGFloat
   private var shadowProminence: ShadowProminence
   private var contentMode: ContentMode

   init(
      imagePath: String? = nil,
      artworkImage: UIImage? = nil,
      sizeType: SizeType = .none,
      shadowProminence: ShadowProminence = .none,
      contentMode: ContentMode = .fill,
      visibleSide: Binding<FlipViewSide> = .constant(.front),
      selected: Bool = false
   ) {
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
         MediaImageContainer(sizeType: sizeType, shadowProminence: shadowProminence) {
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
            .overlay {
               if selected {
                  ZStack {
                     Color.gray.opacity(0.6)
                     AudioVisualizerBars(color: .white)
                  }
               }
            }
         }
      } back: {
         MediaImageContainer(sizeType: sizeType, shadowProminence: shadowProminence) {
            DefaultImage(sizeType: sizeType)
         }

      }
      .animation(.flipCard, value: visibleSide == .back)
   }
}

struct MediaImageContainer<Content: View>: View {
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
         .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(Color.secondary.opacity(0.2), lineWidth: 0.8))
         .background(RoundedRectangle(cornerRadius: cornerRadius).stroke(shadowProminence == .none ? .clear : .black.opacity(0.3), lineWidth: 3).blur(radius: shadowProminence.radius))
   }
}

// MARK: - Types

enum ShadowProminence: CGFloat {
   case none = 0
   case mild = 4
   case full = 8
   
   var radius: CGFloat { self.rawValue }
}

// MARK: - Previews

struct MediaImageView_Previews: PreviewProvider {
   struct MediaImageViewExample: View {
      @State private var visibleSide = FlipViewSide.front
      
      var body: some View {
         ZStack {
            Color.indigo.ignoresSafeArea()
            
            MediaImageView(artworkImage: UIImage(named: "p0"), sizeType: .albumDetail, shadowProminence: .full, visibleSide: $visibleSide)
               .onTapGesture {
                  visibleSide.toggle()
               }
         }
      }
   }
   static var previews: some View {
      MediaImageViewExample()
   }
}

