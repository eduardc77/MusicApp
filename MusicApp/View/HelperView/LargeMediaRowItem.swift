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
    var body: some View {
        
        VStack {
            Spacer()
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
                    MediaImageView(image: Image(uiImage: uiImage), size: Size(width: geometry.size.width, height: geometry.size.height), contentMode: .fill)
                } else if let artworkImage = media.artwork {
                    MediaImageView(image: artworkImage, size: Size(width: geometry.size.width, height: geometry.size.height), contentMode: .fill)
                } else {
                    MediaImageView(size: Size(width: geometry.size.width, height: geometry.size.height))
                }
            }
        }
    }
}

struct LargeMediaRowItem_Previews: PreviewProvider {
    struct LargeMediaRowItemExample: View {
        let media = Media(id: "", artistName: "Placeholder Artist", description: "Placeholder Description", artwork: Image("bigradio1"), collectionName: "Placeholder Name")
        
        var body: some View {
            LargeMediaRowItem(media: media)
        }
    }
    
    static var previews: some View {
        LargeMediaRowItemExample()
    }
}