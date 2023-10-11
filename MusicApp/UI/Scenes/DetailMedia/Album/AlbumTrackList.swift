//
//  AlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumTrackList: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var mediaItemModel: MediaItemModel
   var media: Media
   
   var body: some View {
      Group {
         if mediaItemModel.loadingTracks {
            LoadingView()
            
         } else {
            LazyVStack(alignment: .leading, spacing: .zero) {
               ForEach(Array(mediaItemModel.tracks.enumerated()), id: \.element) { trackIndex, track in
                  Button {
                     mediaItemModel.playTrack(withId: track.id)
                  } label: {
                     VStack {
                        if trackIndex == 0 { Divider() }
                        Spacer()
                        
                        HStack {
                           Group {
                              if playerModel.nowPlayingItem.trackName == track.trackName {
                                 NowPlayingEqualizerBars()
                                    .frame(width: 16, height: 8)
                              } else {
                                 Text(track.trackNumber)
                                    .font(.body)
                                    .foregroundStyle(Color.secondary)
                                    .lineLimit(1)
                              }
                           }
                           .frame(width: 20, height: 8)
                           
                           MediaItemTitle(name: track.trackName, explicitness: track.trackExplicitness)
                           
                           Spacer()
                           
                           MenuButton().padding(.trailing)
                        }
                        .padding(.vertical, 8)
                        
                        Spacer()
                        
                        Divider().padding(.leading, trackIndex == mediaItemModel.trackCount - 1 ? 0 : 20)
                     }
                     .padding(.leading, 20)
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .contentShape(Rectangle())
                  }
                  .buttonStyle(.rowButton)
               }
            }
            
            VStack(alignment: .leading, spacing: 4) {
               if let releaseDate = media.releaseDate {
                  Text("\(releaseDate)")
               }
               
               Text("\(media.trackCount) songs, \(mediaItemModel.albumDuration) minutes")
            }
            .font(.footnote)
            .foregroundStyle(Color.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .padding(.horizontal)
         }
      }
      .task {
         mediaItemModel.fetchTracks(for: media.id)
      }
   }
}


// MARK: - Previews

struct AlbumTrackList_Previews: PreviewProvider {
   static var previews: some View {
      AlbumTrackList(mediaItemModel: MediaItemModel(), media: musicPlaylists2.first ?? Media())
   }
}
