//
//  TrackMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 25.04.2022.
//

import SwiftUI
import MediaPlayer

struct TrackMediaRow: View {
    var media: Media

    var body: some View {
        VStack(spacing: 5) {
            Divider()
                .padding(.leading, 60)
            
            HStack(spacing: 14) {
                if let uiImage = media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: Metric.trackCarouselImageSize, height: Metric.trackCarouselImageSize))
                } else {
                    MediaImageView(imagePath: media.artworkPath.resizedPath(size: 160), size: Size(width: Metric.trackCarouselImageSize, height: Metric.trackCarouselImageSize))
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .subheadline)
                        
                        Text(media.albumAndReleaseYear)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    
                    Image(systemName: "ellipsis")
                        .padding(.trailing, 6)
                }
            }
            
            .onTapGesture {
                // FIXME: - Pass the player
                MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
                MPMusicPlayerController.applicationMusicPlayer.play()
            }
        }
        .frame(width: Metric.largeCarouselItemWidth, height: 55)
    }
}



//
//struct SmallMediaRowItem_Previews: PreviewProvider {
//    struct SmallMediaRowItemExample: View {
//        let media = Media(artistName: "Placeholder Artist", trackName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
//        
//        var body: some View {
//            SmallMediaRowItem(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        SmallMediaRowItemExample()
//    }
//}
