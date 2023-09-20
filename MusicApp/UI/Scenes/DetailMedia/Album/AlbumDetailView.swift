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
   
   var media: Media
   
   init(media: Media) {
      self.media = media
      _libraryItemObservableObject = StateObject(wrappedValue: LibraryMediaItemObservableObject(media: media))
   }
   
   var body: some View {
      ScrollView {
         VStack {
            AlbumHeaderView(libraryMediaObservableObject: libraryItemObservableObject, mediaItemObservableObject: mediaItemObservableObject)
            
            if libraryItemObservableObject.media.collectionId == 0 {
               LibraryAlbumTrackList(libraryMediaObservableObject: libraryItemObservableObject)
            } else {
               AlbumTrackList(mediaItemObservableObject: mediaItemObservableObject, media: media)
            }
            
            if playerObservableObject.showPlayerView, !playerObservableObject.expand {
               Spacer(minLength: Metric.playerHeight)
            }
         }
         .navigationBarTitleDisplayMode(.inline)
      }
      
      .toolbar {
         HStack {
            DownloadButton(font: .title2, action: {})
            
            MenuButton(circled: true, font: .title2, backgroundColor: .secondaryButtonBackgroundColor)
         }
      }
   }
}


// MARK: - Previews

struct AlbumDetailView_Previews: PreviewProvider {
   static var previews: some View {
      AlbumDetailView(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerObservableObject())
   }
}
