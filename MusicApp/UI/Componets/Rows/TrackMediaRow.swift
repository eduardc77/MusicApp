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
		VStack(spacing: 5) {
			Divider()
				.padding(.leading, 60)
			
			HStack(spacing: 14) {
				if let uiImage = media.artwork {
					MediaImageView(artworkImage: uiImage, sizeType: .trackRowItem,
										playing: playerObservableObject.isNowPlaying(media: media) ? playerObservableObject.nowPlayingItem.$playing : .constant(false))
				} else {
					MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), sizeType: .trackRowItem,
										playing: playerObservableObject.isNowPlaying(media: media) ? playerObservableObject.nowPlayingItem.$playing : .constant(false))
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
		}
		.frame(width: Metric.largeCarouselItemWidth)

		.onTapGesture {
			playerObservableObject.audioPlayer.stop()
			playerObservableObject.audioPlayer.setQueue(with: [media.id])
			UserDefaults.standard.set([media.id], forKey: UserDefaultsKey.queueDefault)
			playerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.off
			UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
			playerObservableObject.audioPlayer.play()
		}
	}
}

// MARK: - Previews

struct SmallMediaRowItem_Previews: PreviewProvider {
	static var previews: some View {
		TrackMediaRow(media: musicPlaylists2.first ?? Media())
			.environmentObject(PlayerObservableObject())
	}
}
