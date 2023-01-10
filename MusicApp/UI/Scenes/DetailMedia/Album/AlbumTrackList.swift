//
//  AlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumTrackList: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@ObservedObject var mediaItemObservableObject: MediaItemObservableObject
	var media: Media

	var body: some View {
		LazyVStack(alignment: .leading, spacing: 0) {
			ForEach(Array(mediaItemObservableObject.tracks.enumerated()), id: \.element) { trackIndex, track in
				Button {
					mediaItemObservableObject.playTrack(withId: track.id)
				} label: {
					VStack {
						if trackIndex == 0 { Divider() }
						Spacer()

						HStack {
							Group {
								if playerObservableObject.nowPlayingItem.trackName == track.trackName {
									NowPlayingEqualizerBars()
										.frame(width: 16, height: 8)
								} else {
									Text(track.trackNumber)
										.font(.body)
										.foregroundColor(.secondary)
										.lineLimit(1)
								}
							}
							.frame(width: 20, height: 8)

							MediaItemName(name: track.trackName, explicitness: track.trackExplicitness)

							Spacer()

							Image(systemName: "ellipsis")
								.padding(.trailing)
						}
						.padding(.vertical, 8)

						Spacer()

						Divider().padding(.leading, trackIndex == mediaItemObservableObject.trackCount - 1 ? 0 : 20)
					}
					.padding(.leading, 20)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.contentShape(Rectangle())
				}
				.buttonStyle(.rowButton)
			}
		}
		.task {
			mediaItemObservableObject.fetchTracks(for: media.id)
		}

		VStack(alignment: .leading, spacing: 4) {
			if let releaseDate = media.releaseDate {
				Text("\(releaseDate)")
			}

			Text("\(media.trackCount) songs, \(mediaItemObservableObject.albumDuration) minutes")
		}
		.font(.footnote)
		.foregroundColor(.secondary)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.vertical, 8)
		.padding(.horizontal)
	}
}


// MARK: - Previews

struct AlbumTrackList_Previews: PreviewProvider {
	static var previews: some View {
		AlbumTrackList(mediaItemObservableObject: MediaItemObservableObject(), media: musicPlaylists2.first ?? Media())
	}
}
