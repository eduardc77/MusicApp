//
//  TrackMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 25.04.2022.
//

import SwiftUI
import MediaPlayer

struct TrackMediaRow: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	var media: Media
	
	var body: some View {
		VStack(spacing: 5) {
			Divider()
				.padding(.leading, 60)
			
			HStack(spacing: 14) {
				if let uiImage = media.artwork {
					MediaImageView(artworkImage: uiImage, sizeType: .trackRowItem, playing: playerObservableObject.nowPlayingItem.$playing)
				} else {
					MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), sizeType: .trackRowItem, playing: playerObservableObject.nowPlayingItem.$playing)
				}
				
				HStack {
					VStack(alignment: .leading, spacing: 3) {
						MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .subheadline)
						
						Text(media.albumAndReleaseYear)
							.font(.caption)
							.foregroundColor(.secondary)
					}
					
					.frame(maxWidth: .infinity, alignment: .leading)
					.lineLimit(1)
					
					Image(systemName: "ellipsis")
						.padding(.trailing, 6)
				}
			}
			
			.onTapGesture {
				MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
				MPMusicPlayerController.applicationMusicPlayer.play()
			}
		}
		.frame(width: Metric.largeCarouselItemWidth)
	}
}

// MARK: - Previews

struct SmallMediaRowItem_Previews: PreviewProvider {
	static var previews: some View {
		TrackMediaRow(media: musicPlaylists2.first ?? Media())
			.environmentObject(PlayerObservableObject())
	}
}
