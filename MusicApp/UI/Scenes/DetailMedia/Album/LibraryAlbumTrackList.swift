//
//  LibraryAlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct LibraryAlbumTrackList: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@ObservedObject var libraryMediaObservableObject: LibraryMediaItemObservableObject

	var body: some View {
		LazyVStack(alignment: .leading, spacing: 0) {
			ForEach(libraryMediaObservableObject.libraryTracks.indices, id: \.self) { trackIndex in
				Button {
					libraryMediaObservableObject.playTrack(at: trackIndex)
				} label: {
					VStack {
						if trackIndex == 0 { Divider() }
						Spacer()
						
						HStack {
							Group {
								if playerObservableObject.nowPlayingItem.trackName == libraryMediaObservableObject.trackTitle(at: trackIndex) {
									NowPlayingEqualizerBars()
										.frame(width: 16, height: 8)
								} else {
									Text(String(libraryMediaObservableObject.trackNumber(at: trackIndex)))
										.font(.body)
										.foregroundColor(.secondary)
										.lineLimit(1)
								}
							}
							.frame(width: 20, height: 8)

							MediaItemName(name: libraryMediaObservableObject.trackTitle(at: trackIndex), explicitness: libraryMediaObservableObject.trackExplicitness(at: trackIndex) ? .explicit : .notExplicit)
							
							Spacer()
							
							MenuButton().padding(.trailing)
						}
						.padding(.vertical, 8)

						Spacer()

						Divider().padding(.leading, trackIndex == libraryMediaObservableObject.trackCount - 1 ? 0 : 20)
					}
					.padding(.leading, 20)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.contentShape(Rectangle())
				}
				.buttonStyle(.rowButton)
			}

		}

		VStack(alignment: .leading, spacing: 4) {
			if let releaseDate = libraryMediaObservableObject.media.releaseDate {
				Text("\(releaseDate)")
			}

			Text("\(libraryMediaObservableObject.trackCount) songs, \(libraryMediaObservableObject.albumDuration) minutes")
		}
		.font(.footnote)
		.foregroundColor(.secondary)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.vertical, 8)
		.padding(.horizontal)
	}
}


// MARK: - Previews

struct LibraryAlbumTrackList_Previews: PreviewProvider {
	static var previews: some View {
		LibraryAlbumTrackList(libraryMediaObservableObject: LibraryMediaItemObservableObject(media: musicPlaylists2.first ?? Media()))
	}
}
