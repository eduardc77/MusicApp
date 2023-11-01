//
//  AlbumDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @StateObject private var libraryMediaItemModel: LibraryMediaItemModel
   @StateObject private var mediaItemModel: MediaItemModel = MediaItemModel()
   
   var media: Media
   
   init(media: Media) {
      self.media = media
      _libraryMediaItemModel = StateObject(wrappedValue: LibraryMediaItemModel(media: media))
   }
   
   var body: some View {
      ScrollView {
         VStack {
            AlbumHeaderView(libraryMediaItemModel: libraryMediaItemModel, mediaItemModel: mediaItemModel)
            
            if libraryMediaItemModel.media.collectionId == 0 {
               LibraryAlbumTrackList(model: libraryMediaItemModel)
            } else {
               AlbumTrackList(mediaItemModel: mediaItemModel, media: media)
            }
            
            if playerModel.showPlayerView, !playerModel.expand {
               Spacer(minLength: Metric.playerHeight)
            }
         }
         .navigationBarTitleDisplayMode(.inline)
      }
      .toolbar {
         ToolbarItemGroup(placement: .topBarTrailing) {
            ToolbarButton(title: "Download", iconName: "arrow.down") {}
            MenuButton(circled: true, font: .title2, backgroundColor: .secondaryButtonBackgroundColor)
         }
      }
   }
}


// MARK: - Previews

struct AlbumDetailView_Previews: PreviewProvider {
   static var previews: some View {
      AlbumDetailView(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerModel())
   }
}
