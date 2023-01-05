//
//  AlbumMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI

struct AlbumMediaRow: View {
  var media: Media
  var imageData: Data?
  var action: () -> Void
  
  var body: some View {
    VStack {
      HStack(spacing: 16) {
        if let uiImage = media.artwork {
          MediaImageView(artworkImage: uiImage, sizeType: .albumCollectionRow)
        } else {
          MediaImageView(imagePath: media.artworkPath.resizedPath(size: 260), sizeType: .albumCollectionRow)
        }
        
        VStack(alignment: .leading) {
          HStack {
            VStack(alignment: .leading, spacing: 3) {
              Text(media.releaseDate ?? "")
                .foregroundColor(.secondary)
                .font(.caption2.bold())
              
              MediaItemName(name: media.name, explicitness: media.collectionExplicitness, font: .callout)
              
              Text(!media.trackCount.isEmpty ? "\(media.trackCount) songs" : "")
                .foregroundColor(.secondary)
                .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(2)
            
            Image(systemName: "ellipsis")
              .padding(.horizontal)
          }
          
          MainButton(title: "Add", font: Font.footnote.bold(), image: Image(systemName: "plus"), spacing: 3, size: Size(height: 12), cornerRadius: 16) { action() }
        }
      }
    }
    .padding()
  }
}


// MARK: - Previews

struct AlbumMediaRow_Previews: PreviewProvider {
	static var previews: some View {
		AlbumMediaRow(media: musicPlaylists2.first ?? Media(), action: {})
	}
}
