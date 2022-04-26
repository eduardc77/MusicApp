//
//  MediumMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct MediumMediaRowItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    MediaImageView(image: Image(uiImage: uiImage), size: Size(width: Metric.mediumImageSize, height: Metric.mediumImageSize))
                } else if let artworkImage = media.artwork {
                    MediaImageView(image: Image(uiImage: artworkImage), size: Size(width: Metric.mediumImageSize, height: Metric.mediumImageSize))
                } else {
                    MediaImageView(size: Size(width: Metric.mediumImageSize, height: Metric.mediumImageSize))
                }
             
                Text(media.collectionName ?? "")
                    .foregroundColor(.primary)
                    .font(.caption)
                    .frame(maxWidth: Metric.mediumImageSize, alignment: .leading)
                    .lineLimit(1)
                    
                
                Text(media.description ?? "")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .frame(maxWidth: Metric.mediumImageSize, alignment: .leading)
                    .lineLimit(1)
            }
        }
        
    }
}

struct MediumMediaRowItem_Previews: PreviewProvider {
    struct MediumMediaRowItemExample: View {
        let media = Media(id: "", artistName: "Placeholder Artist", description: "Placeholder Description", artwork: UIImage(named: "bigradio1"), collectionName: "Placeholder Name")
        
        var body: some View {
            MediumMediaRowItem(media: media)
        }
    }
    
    static var previews: some View {
        MediumMediaRowItemExample()
    }
}
