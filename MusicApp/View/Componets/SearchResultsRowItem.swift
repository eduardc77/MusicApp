//
//  SmallMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchResultsRowItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        HStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                MediaImageView(image: Image(uiImage: uiImage), size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            } else if let artworkImage = media.artwork {
                MediaImageView(image: artworkImage, size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            } else {
                MediaImageView(size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            }
            
            VStack(alignment: .leading) {
                Text(media.trackName ?? media.collectionName ?? media.artistName ?? "")
                    .foregroundColor(.primary)
                    .font(.callout)
                    .lineLimit(1)
                
                Text(media.artistName ?? "")
                    .foregroundColor(.secondary)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
    }
}

struct SearchResultsRowItem_Previews: PreviewProvider {
    struct SearchResultsRowItemExample: View {
        let media = Media(artistName: "Placeholder Artist", trackName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
        
        var body: some View {
            SearchResultsRowItem(media: media)
        }
    }
    
    static var previews: some View {
        SearchResultsRowItemExample()
    }
}
