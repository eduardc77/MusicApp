//
//  TrackMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 25.04.2022.
//

import SwiftUI
import MediaPlayer

struct TrackMediaRow: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   @State var media: Media
   var sizeType: SizeType = .trackRowItem
   
   var body: some View {
      Button {
         playerObservableObject.play(media)
      } label: {
         
         HStack(spacing: 10) {
            Group {
               if let uiImage = media.artwork {
                  MediaImageView(artworkImage: uiImage, sizeType: sizeType, selected: playerObservableObject.isNowPlaying(media: media))
               } else {
                  MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), sizeType: sizeType, selected: playerObservableObject.isNowPlaying(media: media))
               }
            }
            .scaleEffect(0.88).offset(x: -4)
            
            VStack(spacing: 0) {
               Divider()
               Spacer()
               
               HStack {
                  VStack(alignment: .leading, spacing: 3) {
                     MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .body)
                     
                     Text(media.albumAndReleaseYear)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .lineLimit(1)
                  
                  Image(systemName: "ellipsis")
                     .padding(.trailing, 6)
               }
               Spacer()
            }
         }
         .frame(width: Metric.largeCarouselItemWidth)
         .contentShape(Rectangle())
      }
      .buttonStyle(.rowButton)
   }
}

// MARK: - Previews

struct TrackMediaRow_Previews: PreviewProvider {
   static var previews: some View {
      TrackMediaRow(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerObservableObject())
   }
}
