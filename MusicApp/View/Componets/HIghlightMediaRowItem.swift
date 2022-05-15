//
//  HighlightMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct HighlightMediaRowItem: View {
    var media: Media
    var imageData: Data?
    var spacing: CGFloat = 10
    
    var body: some View {
        VStack(spacing: spacing) {
            VStack(alignment: .leading) {
                Text(media.kind.entityUppercased)
                    .font(.caption).bold()
                    .foregroundColor(.secondary)
                
                Text(media.collectionName)
                    .font(.title2)
                
                Text(media.description)
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { geometry in
                if let uiImage = media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: geometry.size.width, height: geometry.size.height - spacing), contentMode: .fill)
                } else {
                    MediaImageView(imagePath: media.artworkPath.resizedPath(size: 800), size: Size(width: geometry.size.width, height: geometry.size.height - spacing), contentMode: .fill)
                }
                
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
