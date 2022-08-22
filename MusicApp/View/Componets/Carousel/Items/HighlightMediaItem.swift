//
//  HighlightMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct HighlightMediaItem: View {
    var media: Media
    var imageData: Data?

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(media.kind.titleUppercased)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                Text(media.name)
                    .font(.title3)
                
                Text(media.trackName)
                    .foregroundColor(.secondary)
                    .font(.title3)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let uiImage = media.artwork {
                MediaImageView(artworkImage: uiImage, sizeType: .highlight, contentMode: .fill)
            } else {
                MediaImageView(imagePath: media.artworkPath.resizedPath(size: 800), sizeType: .highlight, contentMode: .fill)
            }
        }
    }
}
//
//struct LargeMediaRowItem_Previews: PreviewProvider {
//    struct LargeMediaRowItemExample: View {
//        let media = Media(artistName: "Placeholder Artist", collectionName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
//        
//        var body: some View {
//            LargeMediaRowItem(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        LargeMediaRowItemExample()
//    }
//}
