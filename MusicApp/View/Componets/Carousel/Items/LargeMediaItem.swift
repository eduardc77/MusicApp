//
//  LargeMediaItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import MediaPlayer

struct LargeMediaItem: View {
    @EnvironmentObject var playerObservableObject: PlayerObservableObject
    
    var media: Media
    var imageData: Data?

    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, size: Size(width: Metric.largeCarouselImageWidth , height: Metric.largeCarouselImageHeight), contentMode: .fill)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 1024), size: Size(width: Metric.screenWidth - 44, height: Metric.largeCarouselImageHeight), contentMode: .fill)
            }
            
            VStack {
                Text(media.name)
                    .foregroundColor(.primary)
                    .frame(maxWidth: Metric.largeCarouselImageWidth, alignment: .leading)
                Text(media.artistName)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: Metric.largeCarouselImageWidth, alignment: .leading)
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
