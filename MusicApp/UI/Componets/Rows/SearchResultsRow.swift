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
   
   init(media: Media) {
      self.media = media
   }
   
   var body: some View {
      HStack {
         if let uiImage = media.artwork {
            MediaImageView(artworkImage: uiImage, sizeType: .searchRow, selected: playerObservableObject.isNowPlaying(media: media))
         } else {
            MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow, selected: playerObservableObject.isNowPlaying(media: media))
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
            
            MenuButton().padding(.trailing, 6)
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
