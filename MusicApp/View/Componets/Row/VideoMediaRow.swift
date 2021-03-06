//
//  VideoMediaRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.05.2022.
//

import SwiftUI

struct VideoMediaRow: View {
    @EnvironmentObject var playerObservableObject: PlayerObservableObject
    
    var media: Media
    
    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, size: Size(width: Metric.albumCarouselImageSize, height: Metric.videoRowHeight), contentMode: .fill)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 360), size: Size(width: Metric.albumCarouselImageSize, height: Metric.videoRowHeight), contentMode: .fill)
            }
            
            VStack {
                Text(media.name)
                    .foregroundColor(.primary)
                    .frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
                Text(media.artistName)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: Metric.albumCarouselImageSize, alignment: .leading)
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
