//
//  SearchResultsRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchResultsRow: View {
   @EnvironmentObject private var playerModel: PlayerModel
   var media: Media
   
   init(media: Media) {
      self.media = media
   }
   
   var body: some View {
      HStack {
         if let uiImage = media.artwork {
            MediaImageViewContainer(artworkImage: uiImage, sizeType: .searchRow, selected: playerModel.isNowPlaying(media: media))
         } else {
            MediaImageViewContainer(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow, selected: playerModel.isNowPlaying(media: media))
         }
         
         HStack {
            VStack(alignment: .leading) {
               MediaItemTitle(name: media.name, explicitness: media.trackExplicitness, font: .callout)
               
               Text("\(media.kind.title) · \(media.artistName)")
                  .foregroundStyle(Color.secondary)
                  .font(.callout)
                  .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            MenuButton().padding(.trailing, 6)
               .controlSize(.extraLarge)
         }
      }
   }
}


// MARK: - Previews

struct SearchResultsRow_Previews: PreviewProvider {
   struct SearchResultsRowExample: View {
      
      var body: some View {
         SearchResultsRow(media: musicPlaylists2.first ?? Media())
            .environmentObject(PlayerModel())
            .padding()
      }
   }
   
   static var previews: some View {
      SearchResultsRowExample()
   }
}
