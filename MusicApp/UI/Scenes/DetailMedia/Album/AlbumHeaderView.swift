//
//  AlbumHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumHeaderView: View {
	@ObservedObject var libraryMediaObservableObject: LibraryMediaItemObservableObject
	@ObservedObject var mediaItemObservableObject: MediaItemObservableObject

	var body: some View {
		VStack {
			VStack {
				if let uiImage = libraryMediaObservableObject.media.artwork {
					MediaImageView(artworkImage: uiImage, sizeType: .albumDetail, shadowProminence: .full)
				} else {
					MediaImageView(imagePath: libraryMediaObservableObject.media.artworkPath.resizedPath(size: 800), sizeType: .albumDetail, shadowProminence: .full)
				}

				albumDetails
					.padding(.top, 6)
			}
			.padding(.top, 6)
			.padding(.horizontal)

			albumControls

			Spacer(minLength: 20)
		}
		.padding(.bottom, 3)
	}

	var albumDetails: some View {
		VStack(spacing: 3) {
			Text(libraryMediaObservableObject.media.collectionName)
				.font(.title3.bold())
				.foregroundColor(.primary)

			Text(libraryMediaObservableObject.media.artistName)
				.font(.title3)
				.foregroundColor(.appAccentColor)

			Text(libraryMediaObservableObject.media.genreAndReleaseYear)
				.font(.caption.bold())
				.foregroundColor(.secondary)
		}
		.lineLimit(2)
		.multilineTextAlignment(.center)
	}

	var albumControls: some View {
		HStack {
			MainButton(title: "Play", image: Image(systemName: "play.fill")) {
				if libraryMediaObservableObject.media.dateAdded != nil {
					libraryMediaObservableObject.playAllTracks(isShuffle: false)
				} else {
					mediaItemObservableObject.playAllTracks(isShuffle: false)
				}
			}

			Spacer(minLength: 20)

			MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
				if libraryMediaObservableObject.media.dateAdded != nil {
					libraryMediaObservableObject.playAllTracks(isShuffle: true)
				} else {
					mediaItemObservableObject.playAllTracks(isShuffle: true)
				}
			}
		}
		.padding(.horizontal)
		.padding(.top, 6)
	}
}


// MARK: - Previews

struct AlbumHeaderView_Previews: PreviewProvider {
	static var previews: some View {
		AlbumHeaderView(libraryMediaObservableObject: LibraryMediaItemObservableObject(media: musicPlaylists2.first ?? Media()), mediaItemObservableObject: MediaItemObservableObject())
	}
}
