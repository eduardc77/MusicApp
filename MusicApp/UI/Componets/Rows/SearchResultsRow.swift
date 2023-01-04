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
	@State var playing: Bool = false
	
	init(media: Media, isPlaying: Binding<Bool>) {
		self.media = media
		_playing = State(wrappedValue: isPlaying.wrappedValue)
	}
	
	var body: some View {
		HStack {
			if let uiImage = media.artwork {
				MediaImageView(artworkImage: uiImage, sizeType: .searchRow, playing: playerObservableObject.isNowPlaying(media: media) ? playerObservableObject.nowPlayingItem.$playing : .constant(false))
			} else {
				MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow, playing: playerObservableObject.isNowPlaying(media: media) ? playerObservableObject.nowPlayingItem.$playing : .constant(false))
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

struct SearchResultsRow_Previews: PreviewProvider {
	struct SearchResultsRowExample: View {
		@State var playing: Bool = false
		
		var body: some View {
			SearchResultsRow(media: musicPlaylists2.first ?? Media(), isPlaying: $playing)
				.environmentObject(PlayerObservableObject())
				.padding()
		}
	}
	
	static var previews: some View {
		SearchResultsRowExample()
	}
}
