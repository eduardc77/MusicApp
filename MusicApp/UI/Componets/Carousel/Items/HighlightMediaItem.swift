//
//  HighlightMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct HighlightMediaItem: View {
   var media: Media
   var imageData: Data?
   
   var body: some View {
      NavigationLink(destination: AlbumDetailView(media: media)) {
         VStack {
            VStack(alignment: .leading) {
               Text(media.name)
                  .font(.caption.weight(.semibold))
                  .foregroundStyle(Color.secondary)
               
               Text(media.name)
                  .font(.title2)
               
               Text(media.name)
                  .foregroundStyle(Color.secondary)
                  .font(.title2)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let uiImage = media.artwork {
               MediaImageViewContainer(artworkImage: uiImage, sizeType: .highlightCarouselItem)
            } else {
               MediaImageViewContainer(imagePath: media.artworkPath.resizedPath(size: 800), sizeType: .highlightCarouselItem)
            }
         }
      }
   }
}


// MARK: - Previews

struct LargeMediaRowItem_Previews: PreviewProvider {
   static var previews: some View {
      HighlightMediaItem(media: musicPlaylists2.first ?? Media())
         .padding()
   }
}
