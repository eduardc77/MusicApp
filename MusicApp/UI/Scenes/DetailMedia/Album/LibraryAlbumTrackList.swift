//
//  LibraryAlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct LibraryAlbumTrackList: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var libraryMediaItemModel: LibraryMediaItemModel
   
   var body: some View {
      LazyVStack(alignment: .leading, spacing: 0) {
         ForEach(libraryMediaItemModel.libraryTracks.indices, id: \.self) { trackIndex in
            Button {
               libraryMediaItemModel.playTrack(at: trackIndex)
            } label: {
               VStack {
                  if trackIndex == 0 { Divider() }
                  Spacer()
                  
                  HStack {
                     Group {
                        if playerModel.nowPlayingItem.trackName == libraryMediaItemModel.trackTitle(at: trackIndex) {
                           NowPlayingEqualizerBars()
                              .frame(width: 16, height: 8)
                        } else {
                           Text(String(libraryMediaItemModel.trackNumber(at: trackIndex)))
                              .font(.body)
                              .foregroundStyle(Color.secondary)
                              .lineLimit(1)
                        }
                     }
                     .frame(width: 20, height: 8)
                     
                     MediaItemTitle(name: libraryMediaItemModel.trackTitle(at: trackIndex), explicitness: libraryMediaItemModel.trackExplicitness(at: trackIndex) ? .explicit : .notExplicit)
                     
                     Spacer()
                     
                     MenuButton().padding(.trailing)
                  }
                  .padding(.vertical, 8)
                  
                  Spacer()
                  
                  Divider().padding(.leading, trackIndex == libraryMediaItemModel.trackCount - 1 ? 0 : 20)
               }
               .padding(.leading, 20)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .contentShape(Rectangle())
            }
            .buttonStyle(.rowButton)
         }
         
      }
      
      VStack(alignment: .leading, spacing: 4) {
         if let releaseDate = libraryMediaItemModel.media.releaseDate {
            Text("\(releaseDate)")
         }
         
         Text("\(libraryMediaItemModel.trackCount) songs, \(libraryMediaItemModel.albumDuration) minutes")
      }
      .font(.footnote)
      .foregroundStyle(Color.secondary)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 8)
      .padding(.horizontal)
   }
}


// MARK: - Previews

struct LibraryAlbumTrackList_Previews: PreviewProvider {
   static var previews: some View {
      LibraryAlbumTrackList(libraryMediaItemModel: LibraryMediaItemModel(media: musicPlaylists2.first ?? Media()))
   }
}
