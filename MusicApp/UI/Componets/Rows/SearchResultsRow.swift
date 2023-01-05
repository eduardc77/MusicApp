//
//  SearchResultsRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchResultsRow: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	var media: Media
	@State private var playingStarted: Bool = false
	
	init(media: Media) {
		self.media = media
	}
	
	var body: some View {
		HStack {
			if let uiImage = media.artwork {
				MediaImageView(artworkImage: uiImage, sizeType: .searchRow, selected: playerObservableObject.isNowPlaying(media: media), playing: $playingStarted)
			} else {
				MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow, selected: playerObservableObject.isNowPlaying(media: media), playing: playerObservableObject.isNowPlaying(media: media) ? $playingStarted : .constant(false))
			}
			
			HStack {
				VStack(alignment: .leading) {
					MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .callout)
					
					Text("\(media.kind.title) · \(media.artistName)")
						.foregroundColor(.secondary)
						.font(.callout)
						.lineLimit(1)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Image(systemName: "ellipsis")
					.padding(.trailing, 6)
			}
		}
		.contentShape(Rectangle())
		
		.onTapGesture {
			PlayerObservableObject.audioPlayer.stop()
			PlayerObservableObject.audioPlayer.setQueue(with: [media.id])
			UserDefaults.standard.set([media.id], forKey: UserDefaultsKey.queueDefault)
			PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.off
			UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
			playingStarted = true
			PlayerObservableObject.audioPlayer.play()
		}

		.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
			if PlayerObservableObject.audioPlayer.playbackState == .playing {
				playingStarted = true
			} else if PlayerObservableObject.audioPlayer.playbackState == .paused {
				playingStarted = false
			}
		}
	}
}


// MARK: - Previews

struct SearchResultsRow_Previews: PreviewProvider {
	struct SearchResultsRowExample: View {
		
		var body: some View {
			SearchResultsRow(media: musicPlaylists2.first ?? Media())
				.environmentObject(PlayerObservableObject())
				.padding()
		}
	}
	
	static var previews: some View {
		SearchResultsRowExample()
	}
}
