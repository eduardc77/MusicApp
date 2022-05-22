//
//  SearchCollectionRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI
import MediaPlayer

struct SearchWrapperRow<Content: View>: View {
    var media: Media
    var destinationView: Content
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            HStack {
                if let uiImage = media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
                } else {
                    MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
                }
                
                VStack(alignment: .leading) {
                    switch media.wrapperType {
                    case .collection:
                        MediaItemName(name: media.collectionName, explicitness: media.collectionExplicitness, font: .callout)
                    default:
                        Text(media.name)
                            .foregroundColor(.primary)
                            .font(.callout)
                            .lineLimit(1)

                    }
                    
                    Text("\(media.kind.title) · \(media.artistName)")
                        .foregroundColor(.secondary)
                        .font(.callout)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
