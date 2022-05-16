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
    var spacing: CGFloat = 10

    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, size: Size(height: Metric.largeImageSize), contentMode: .fill)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 1024), size: Size(height: Metric.largeImageSize), contentMode: .fill)
            }
            
            VStack {
                Text(media.name)
                    .foregroundColor(.primary)
                    .frame(maxWidth: Metric.screenWidth * 0.92, alignment: .leading)
                Text(media.artistName)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: Metric.screenWidth * 0.92, alignment: .leading)
            }
            .font(.caption)
            .lineLimit(1)
        }
        .frame(width: Metric.screenWidth * 0.92)
        
        .onTapGesture {         
            withAnimation {
                playerObservableObject.configureVideoPlayer(with: media.previewUrl)
            }
        }
    }
}
