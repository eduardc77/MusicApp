//
//  ArtistFeaturedAlbumRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI

struct ArtistFeaturedAlbumRow: View {
   var media: Media
   var imageData: Data?
   var action: () -> Void
   
   var body: some View {
      VStack {
         HStack(spacing: 16) {
            if let uiImage = media.artwork {
               MediaImageView(artworkImage: uiImage, sizeType: .artistFeatureAlbumItem)
            } else {
               MediaImageView(imagePath: media.artworkPath.resizedPath(size: 260), sizeType: .artistFeatureAlbumItem)
            }
            
            VStack(alignment: .leading) {
                  VStack(alignment: .leading) {
                     Text(media.releaseDate ?? "")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote.weight(.bold))
                     
                     MediaItemTitle(name: media.name, explicitness: media.collectionExplicitness, font: .title3)
                     
                     Text(!media.trackCount.isEmpty ? "\(media.trackCount) songs" : "")
                        .foregroundStyle(Color.secondary)
                        .font(.callout)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .lineLimit(2)
               
               MainButton(title: "Add", font: .headline.bold(), image: Image(systemName: "plus"), spacing: 3, size: Size(height: 12), cornerRadius: 16) { action() }
            }
         }
      }
      .padding()
   }
}


// MARK: - Previews

struct AlbumMediaRow_Previews: PreviewProvider {
   static var previews: some View {
      ArtistFeaturedAlbumRow(media: musicPlaylists2.first ?? Media(), action: {})
   }
}
