//
//  VideoMediaItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import MediaPlayer

struct VideoMediaItem: View {
    @EnvironmentObject var playerObservableObject: PlayerObservableObject
    
    var media: Media
    var imageData: Data?

    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, size: Size(width: Metric.largeCarouselItemWidth , height: Metric.videoCarouselItemHeight), contentMode: .fill)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 1024), size: Size(width: Metric.largeCarouselItemWidth, height: Metric.videoCarouselItemHeight), contentMode: .fill)
            }
            
            VStack {
                MediaItemName(name: media.name, explicitness: media.trackExplicitness)

                    .frame(maxWidth: Metric.largeCarouselItemWidth, alignment: .leading)
                Text(media.artistName)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: Metric.largeCarouselItemWidth, alignment: .leading)
            }
            .font(.caption)
            .lineLimit(1)
        }
        
        .onTapGesture {         
            withAnimation {
                playerObservableObject.configureVideoPlayer(with: media.previewUrl)
            }
        }
    }
}
