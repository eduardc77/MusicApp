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
    var spacing: CGFloat = 8
    
    var body: some View {
        VStack(spacing: spacing) {
            VStack(alignment: .leading, spacing: 0) {
                Text(media.kind.entityUppercased)
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Text(media.name)
                    .font(.title2)
                
                Text(media.description)
                    .foregroundColor(.secondary)
                    .font(.title2)
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
