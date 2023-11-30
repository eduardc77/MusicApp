//
//  LibraryAlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct LibraryAlbumTrackList: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var model: LibraryMediaItemModel
   
   @State private var animatePlaying: Bool = false
   
   var body: some View {
      VStack {
          LazyVStack(alignment: .leading, spacing: .zero) {
            ForEach(Array(model.libraryTracks.enumerated()), id: \.element) { trackIndex, track in
                
               Button {
                   playerModel.play(track, with: model.trackIDsQueue)
                   
               } label: {
                  VStack {
                     if trackIndex == 0 { Divider() }
                     Spacer()
                     
                     HStack {
                        Group {
                           if playerModel.nowPlayingItem?.trackName == model.trackTitle(at: trackIndex) {
                              AudioVisualizerBars()
                           } else {
                              Text(String(model.trackNumber(at: trackIndex)))
                                 .font(.body)
                                 .foregroundStyle(Color.secondary)
                                 .lineLimit(1)
                           }
                        }
                        .frame(width: 20, height: 8)
                        
                        MediaItemTitle(name: model.trackTitle(at: trackIndex), explicitness: model.trackExplicitness(at: trackIndex) ? .explicit : .notExplicit)
                        
                        Spacer()
                        
                        MenuButton().padding(.trailing)
                     }
                     .padding(.vertical, 8)
                     
                     Spacer()
                     
                     Divider().padding(.leading, trackIndex == model.trackCount - 1 ? 0 : 20)
                  }
                  .padding(.leading, 20)
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .contentShape(Rectangle())
               }
               .buttonStyle(.rowButton)
            }          
         }
         
         VStack(alignment: .leading, spacing: 4) {
            if let releaseDate = model.media.releaseDate {
               Text("\(releaseDate)")
            }
            
            Text("\(model.trackCount) songs, \(model.albumDuration) minutes")
         }
         .font(.footnote)
         .foregroundStyle(Color.secondary)
         .frame(maxWidth: .infinity, alignment: .leading)
         .padding(.vertical, 8)
         .padding(.horizontal)
      }
      .onChange(of: playerModel.playbackState) { oldValue, newValue in
          DispatchQueue.main.async {
              animatePlaying = newValue == .playing
          }
      }
   }
}


// MARK: - Previews

struct LibraryAlbumTrackList_Previews: PreviewProvider {
   static var previews: some View {
      LibraryAlbumTrackList(model: LibraryMediaItemModel(media: musicPlaylists2.first ?? Media()))
         .environmentObject(PlayerModel())
   }
}
