//
//  MediumMediaItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct MediumMediaItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
            VStack(alignment: .leading) {
                if let uiImage = media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: Metric.mediumCarouselImageSize, height: Metric.mediumCarouselImageSize))
                } else {
                    MediaImageView(imagePath: media.artworkPath.resizedPath(size: 360), size: Size(width: Metric.mediumCarouselImageSize, height: Metric.mediumCarouselImageSize))
                }
                
                VStack {
                    Text(media.name)
                        .foregroundColor(.primary)
                        .frame(maxWidth: Metric.mediumCarouselImageSize, alignment: .leading)
                    Text(media.artistName)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: Metric.mediumCarouselImageSize, alignment: .leading)
                }
                .font(.caption)
                .lineLimit(1)
            }
        }
    }
}

//struct MediumMediaRowItem_Previews: PreviewProvider {
//    struct MediumMediaRowItemExample: View {
//        let media = Media(artistName: "Placeholder Artist", collectionName: "Placeholder Name", description: "Placeholder Description", artwork: Image("p0"))
//
//        var body: some View {
//            MediumMediaRowItem(media: media)
//        }
//    }
//
//    static var previews: some View {
//        MediumMediaRowItemExample()
//    }
//}
