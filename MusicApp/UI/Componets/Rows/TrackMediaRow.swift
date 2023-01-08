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
	@State var media: Media
	
	var body: some View {
		Button {
			playerObservableObject.play(media)
		} label: {
			VStack(spacing: 5) {
				Divider()
					.padding(.leading, 60)

				HStack(spacing: 14) {
					if let uiImage = media.artwork {
						MediaImageView(artworkImage: uiImage, sizeType: .trackRowItem, selected: playerObservableObject.isNowPlaying(media: media))
					} else {
						MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), sizeType: .trackRowItem, selected: playerObservableObject.isNowPlaying(media: media))
					}

					HStack {
						VStack(alignment: .leading, spacing: 3) {
							MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .body)

							Text(media.albumAndReleaseYear)
								.font(.footnote)
								.foregroundColor(.secondary)
						}
						.frame(maxWidth: .infinity, alignment: .leading)
						.lineLimit(1)

						Image(systemName: "ellipsis")
							.padding(.trailing, 6)
					}
				}
			}
			.frame(width: Metric.largeCarouselItemWidth)
			.contentShape(Rectangle())
		}
		.buttonStyle(.rowButton)
	}
}

// MARK: - Previews

struct TrackMediaRow_Previews: PreviewProvider {
	static var previews: some View {
		TrackMediaRow(media: musicPlaylists2.first ?? Media())
			.environmentObject(PlayerObservableObject())
	}
}
