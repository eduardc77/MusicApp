//
//  SearchResultsRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchResultsRow: View {
    var media: Media
    
    var body: some View {
        HStack {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            }

            VStack(alignment: .leading) {
                MediaItemName(name: media.name, explicitness: media.trackExplicitness, font: .callout)
                
                Text("\(media.kind.title) · \(media.artistName)")
                    .foregroundColor(.secondary)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
        .onTapGesture {
            // FIXME: - Pass the player
            MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
            MPMusicPlayerController.applicationMusicPlayer.play()
        }
    }
}

//struct SearchResultsRow_Previews: PreviewProvider {
//    struct SearchResultsRowExample: View {
//        let media = MediaResponse(id: 0, name: "Placeholder", artistName: "Placeholder")
//        
//        var body: some View {
//            SearchResultsRow(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        SearchResultsRowExample()
//    }
//}
