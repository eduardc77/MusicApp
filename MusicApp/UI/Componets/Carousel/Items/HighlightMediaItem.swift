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
		VStack {
			VStack(alignment: .leading) {
				Text(media.mediaType.titleUppercased)
					.font(.caption.weight(.semibold))
					.foregroundColor(.secondary)
				
				Text(media.name)
					.font(.title2)
				
				Text(media.trackName)
					.foregroundColor(.secondary)
					.font(.title2)
			}
			.lineLimit(1)
			.frame(maxWidth: .infinity, alignment: .leading)
			
			if let uiImage = media.artwork {
				MediaImageView(artworkImage: uiImage, sizeType: .highlightCarouselItem, contentMode: .fill)
			} else {
				MediaImageView(imagePath: media.artworkPath.resizedPath(size: 800), sizeType: .highlightCarouselItem, contentMode: .fill)
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
