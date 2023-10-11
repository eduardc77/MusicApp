//
//  VideoMediaItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import MediaPlayer

struct VideoMediaItem: View {
   @EnvironmentObject var playerModel: PlayerModel
   
   var media: Media
   var imageData: Data?
   
   var body: some View {
      VStack(alignment: .leading) {
         if let uiImage = media.artwork {
            MediaImageView(artworkImage: uiImage, sizeType: .videoCarouselItem)
         } else {
            MediaImageView(imagePath: media.artworkPath.resizedPath(size: 1024), sizeType: .videoCarouselItem)
         }
         
         VStack {
            MediaItemTitle(name: media.name, explicitness: media.trackExplicitness)
            
               .frame(maxWidth: Metric.largeCarouselItemWidth, alignment: .leading)
            Text(media.artistName)
               .foregroundStyle(.secondary)
               .frame(maxWidth: Metric.largeCarouselItemWidth, alignment: .leading)
         }
         .font(.caption)
         .lineLimit(1)
      }
      
      .onTapGesture {
         playerModel.play(media, videoAssetUrl: media.previewUrl)
      }
   }
}


// MARK: - Previews

struct VideoMediaItem_Previews: PreviewProvider {
   static var previews: some View {
      VideoMediaItem(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerModel())
   }
}
