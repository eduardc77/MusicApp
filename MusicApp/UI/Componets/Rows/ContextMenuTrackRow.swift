//
//  ContextMenuTrackRow.swift
//  MusicApp
//
//  Created by iMac on 12.10.2023.
//

import SwiftUI

struct ContextMenuTrackRow: View {
   var media: Media
   var imageData: Data?
   
   var body: some View {
      HStack(spacing: 16) {
         if let uiImage = media.artwork {
            MediaImageViewContainer(artworkImage: uiImage, sizeType: .artistFeatureAlbumItem)
         } else {
            MediaImageViewContainer(imagePath: media.artworkPath.resizedPath(size: 260), sizeType: .artistFeatureAlbumItem)
         }
         
         VStack(alignment: .leading) {
            Text(media.releaseDate ?? "")
               .foregroundStyle(Color.secondary)
               .font(.footnote.weight(.bold))
            
            MediaItemTitle(name: media.name, font: .title3, lineLimit: 3)
            
            Text(!media.trackCount.isEmpty ? "\(media.trackCount) songs" : "")
               .foregroundStyle(Color.secondary)
               .font(.callout)
         }
      }
      .padding(.vertical, 24)
      .padding(.horizontal, 20)
      .frame(width: Metric.screenWidth, alignment: .leading)
      .background(.background.secondary)
   }
}


// MARK: - Previews

struct ContextMenuTrackRow_Previews: PreviewProvider {
   static var previews: some View {
      ContextMenuTrackRow(media: musicPlaylists2.first ?? Media())
   }
}
