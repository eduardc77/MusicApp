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
	@StateObject var mediaItemObservableObject: MediaItemObservableObject
	@State private var playingStarted: Bool = false

	var media: Media

	var body: some View {
		Group {
			if mediaItemObservableObject.loadingTracks {
				LoadingView()
			} else {
				VStack(alignment: .leading) {
					ForEach(Array(zip(mediaItemObservableObject.tracks.indices, mediaItemObservableObject.tracks)), id: \.0) { trackIndex, track in
						HStack {
							VStack {
								HStack {
									Group {
										if playerObservableObject.nowPlayingItem.media.trackName == track.trackName {
											NowPlayingEqualizerBars(animating: $playingStarted)
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
							playingStarted = true
							mediaItemObservableObject.playTrack(withId: track.id)
						}

						.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
							if PlayerObservableObject.audioPlayer.playbackState == .playing {
								playingStarted = true
							} else if PlayerObservableObject.audioPlayer.playbackState == .paused {
								playingStarted = false
							}
						}
					}

					VStack(alignment: .leading, spacing: 4) {
						if let releaseDate = media.releaseDate {
							Text("\(releaseDate)")
						}

						Text("\(mediaItemObservableObject.albumTrackCount) songs, \(mediaItemObservableObject.albumDuration) minutes")
					}
					.font(.footnote)
					.foregroundColor(.secondary)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.horizontal)
					.padding(.vertical, 4)
				}

			}
		}
		.task {
         mediaItemObservableObject.fetchTracks(for: media.id)
		}
	}
}


// MARK: - Previews

struct AlbumTrackList_Previews: PreviewProvider {
	static var previews: some View {
		AlbumTrackList(mediaItemObservableObject: MediaItemObservableObject(), media: musicPlaylists2.first ?? Media())
	}
}
