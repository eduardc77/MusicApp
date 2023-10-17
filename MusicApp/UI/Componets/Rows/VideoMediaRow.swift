//
//  VideoMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.05.2022.
//

import SwiftUI

struct VideoMediaRow: View {
   @EnvironmentObject var playerModel: PlayerModel
   
   var media: Media
   
   var body: some View {
      VStack(alignment: .leading) {
         if let uiImage = media.artwork {
            MediaImageView(artworkImage: uiImage, sizeType: .videoCollectionRow)
         } else {
            MediaImageView(imagePath: media.artworkPath.resizedPath(size: 360), sizeType: .videoCollectionRow)
         }
         
         VStack {
            MediaItemTitle(name: media.name, explicitness: media.trackExplicitness, font: .callout)
               .frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
            
            Text(media.artistName)
               .foregroundStyle(Color.secondary)
               .frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
         }
         .font(.caption)
         .lineLimit(1)
      }
      .contentShape(Rectangle())
      .onTapGesture {
         withAnimation {
            playerModel.play(media, videoAssetUrl: media.previewUrl)
         }
      }
   }
}


// MARK: - Previews

struct VideoMediaRow_Previews: PreviewProvider {
   static var previews: some View {
      VideoMediaRow(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerModel())
   }
}
