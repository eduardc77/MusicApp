//
//  AlbumHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumHeaderView: View {
   @ObservedObject var libraryMediaItemModel: LibraryMediaItemModel
   @ObservedObject var mediaItemModel: MediaItemModel
   
   var body: some View {
      VStack {
         VStack {
            if let uiImage = libraryMediaItemModel.media.artwork {
               MediaImageView(artworkImage: uiImage, sizeType: .albumDetail, shadowProminence: .full)
            } else {
               MediaImageView(imagePath: libraryMediaItemModel.media.artworkPath.resizedPath(size: 800), sizeType: .albumDetail, shadowProminence: .full)
            }
            
            albumDetails.padding(.top, 6)
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
         Text(libraryMediaItemModel.media.collectionName)
            .font(.title3.bold())
            .foregroundStyle(Color.primary)
         
         Text(libraryMediaItemModel.media.artistName)
            .font(.title3)
            .foregroundStyle(Color.accentColor)
         
         HStack(spacing: 1) {
            Text(libraryMediaItemModel.media.genreAndReleaseYear)
            Text("·")
            LosslessLogo(bordered: false, color: .secondary)
         }
         .font(.caption.bold())
         .foregroundStyle(Color.secondary)
      }
      .lineLimit(2)
      .multilineTextAlignment(.center)
   }
   
   var albumControls: some View {
      HStack {
         MainButton(title: "Play", image: Image(systemName: "play.fill")) {
            if libraryMediaItemModel.media.dateAdded != nil {
               libraryMediaItemModel.playAllTracks(isShuffle: false)
            } else {
               mediaItemModel.playAllTracks(isShuffle: false)
            }
         }
         
         Spacer(minLength: 20)
         
         MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
            if libraryMediaItemModel.media.dateAdded != nil {
               libraryMediaItemModel.playAllTracks(isShuffle: true)
            } else {
               mediaItemModel.playAllTracks(isShuffle: true)
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
      AlbumHeaderView(libraryMediaItemModel: LibraryMediaItemModel(media: musicPlaylists2.first ?? Media()), mediaItemModel: MediaItemModel())
   }
}
