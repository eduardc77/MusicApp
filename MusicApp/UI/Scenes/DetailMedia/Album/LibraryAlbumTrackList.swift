//
//  LibraryAlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct LibraryAlbumTrackList: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@StateObject var libraryMediaObservableObject: LibraryMediaItemObservableObject
	@State private var playingStarted: Bool = false

	var body: some View {
		VStack(alignment: .leading) {
			ForEach(0 ..< libraryMediaObservableObject.trackCount, id: \.self) { trackIndex in
				HStack {
					VStack {
						HStack {
							Group {
								if playerObservableObject.nowPlayingItem.media.trackName == libraryMediaObservableObject.trackTitle(at: trackIndex) {
									NowPlayingEqualizerBars(animating: $playingStarted)
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

							Image(systemName: "ellipsis")
								.padding(.trailing)
						}
						.padding(.vertical, 8)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(.white.opacity(0.001))

						Divider()
							.padding(.leading, 24)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
				.contentShape(Rectangle())
				.padding(.leading)

				.onTapGesture {
					libraryMediaObservableObject.playTrack(at: trackIndex)
				}

				.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)) { _ in
					if PlayerObservableObject.audioPlayer.playbackState == .playing {
						playingStarted = true
					} else if PlayerObservableObject.audioPlayer.playbackState == .paused {
						playingStarted = false
					}
				}
			}

			VStack(alignment: .leading, spacing: 4) {
				if let releaseDate = libraryMediaObservableObject.media.releaseDate {
					Text("\(releaseDate)")
				}

				Text("\(libraryMediaObservableObject.albumTrackCount) songs, \(libraryMediaObservableObject.albumDuration) minutes")
			}
			.font(.footnote)
			.foregroundColor(.secondary)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal)
			.padding(.vertical, 4)
		}

	}
}


// MARK: - Previews

struct LibraryAlbumTrackList_Previews: PreviewProvider {
	static var previews: some View {
		LibraryAlbumTrackList(libraryMediaObservableObject: LibraryMediaItemObservableObject(media: musicPlaylists2.first ?? Media(), searchObservableObject: SearchObservableObject()))
	}
}
