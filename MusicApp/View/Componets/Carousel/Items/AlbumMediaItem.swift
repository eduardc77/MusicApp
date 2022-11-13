//
//  AlbumMediaItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct AlbumMediaItem: View {
	var media: Media
	
	var body: some View {
		NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
			VStack(alignment: .leading) {
				if let uiImage = media.artwork {
					MediaImageView(artworkImage: uiImage, sizeType: .albumCarouselItem)
				} else {
					MediaImageView(imagePath: media.artworkPath.resizedPath(size: 360), sizeType: .albumCarouselItem)
				}
				
				VStack {
					MediaItemName(name: media.collectionName, explicitness: media.collectionExplicitness)
						.frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
					
					Text(media.artistName)
						.foregroundColor(.secondary)
						.frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
				}
				.font(.caption)
				.lineLimit(1)
			}
			
		}
	}
}


// MARK: - Previews

struct MediumMediaRowItem_Previews: PreviewProvider {
	static var previews: some View {
		AlbumMediaItem(media: musicPlaylists2.first ?? Media())
	}
}
