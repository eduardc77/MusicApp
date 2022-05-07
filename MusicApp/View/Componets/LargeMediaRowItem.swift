//
//  LargeMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct LargeMediaRowItem: View {
    var media: Media
    var imageData: Data?
    var spacing: CGFloat = 10
    
    var body: some View {
        VStack(spacing: spacing) {
            VStack(alignment: .leading) {
                Text(media.kind?.entityUppercased ?? "")
                    .font(.caption).bold()
                    .foregroundColor(.secondary)
                
                Text(media.collectionName ?? "")
                    .font(.title2)
                
                Text(media.description ?? "")
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { geometry in
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    MediaImageView(image: Image(uiImage: uiImage), size: Size(width: geometry.size.width, height: geometry.size.height - spacing), contentMode: .fill)
                    
                } else if let artworkImage = media.artwork {
                    MediaImageView(image: artworkImage, size: Size(width: geometry.size.width, height: geometry.size.height - spacing), contentMode: .fill)
                    
                } else {
                    MediaImageView(size: Size(width: geometry.size.width, height: geometry.size.height - spacing))
                }
            }
        }
    }
}

struct LargeMediaRowItem_Previews: PreviewProvider {
    struct LargeMediaRowItemExample: View {
        let media = Media(artistName: "Placeholder Artist", collectionName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
        
        var body: some View {
            LargeMediaRowItem(media: media)
        }
    }
    
    static var previews: some View {
        LargeMediaRowItemExample()
    }
}
