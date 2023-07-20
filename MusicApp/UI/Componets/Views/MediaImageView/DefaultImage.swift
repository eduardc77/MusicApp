//
//  DefaultImage.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 08.01.2023.
//

import SwiftUI

struct DefaultImage: View {
   let sizeType: SizeType
   
   var body: some View {
      ZStack {
         Color(.lightGray).opacity(sizeType == .largePlayerArtwork ? 1 : 0.1)
         
         Group {
            if sizeType == .artistRow {
               Image(systemName: "music.mic")
                  .resizable()
                  .frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2)
            } else {
               Image("music-note")
                  .resizable()
                  .frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6)
            }
         }
         .aspectRatio(contentMode: .fit)
         .foregroundColor(Color.secondary.opacity(0.8))
      }
   }
}
