//
//  AlbumDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
  @EnvironmentObject private var playerObservableObject: PlayerObservableObject
  @StateObject private var libraryItemObservableObject: LibraryMediaItemObservableObject
	@StateObject private var mediaItemObservableObject: MediaItemObservableObject = MediaItemObservableObject()
  
  init(media: Media, searchObservableObject: SearchObservableObject) {
    _libraryItemObservableObject = StateObject(wrappedValue: LibraryMediaItemObservableObject(media: media, searchObservableObject: searchObservableObject))
  }
  
  var body: some View {
    ScrollView {
      VStack {
			AlbumHeaderView(libraryMediaObservableObject: libraryItemObservableObject, mediaItemObservableObject: mediaItemObservableObject)
        
        if libraryItemObservableObject.media.collectionId == 0 {
          LibraryAlbumTrackList(libraryMediaObservableObject: libraryItemObservableObject)
        } else {
			  AlbumTrackList(mediaItemObservableObject: mediaItemObservableObject, media: libraryItemObservableObject.media)
        }
        
        if playerObservableObject.showPlayerView, !playerObservableObject.expand {
          Spacer(minLength: Metric.playerHeight)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
    
    .toolbar {
      HStack {
        Button { } label: {
          Image(systemName: "arrow.down.circle.fill")
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(Color.appAccentColor, Color.secondary.opacity(0.16))
        }
        
        Button { } label: {
          Image(systemName: "ellipsis.circle.fill")
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(Color.appAccentColor, Color.secondary.opacity(0.16))
        }
      }
    }
  }
}


// MARK: - Previews

struct AlbumDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AlbumDetailView(media: musicPlaylists2.first ?? Media(), searchObservableObject: SearchObservableObject())
			.environmentObject(PlayerObservableObject())
	}
}
