//
//  SmallMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchResultsRowItem: View {
    var media: Media
    
    var body: some View {
        HStack {
            MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), size: Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize))
            
            VStack(alignment: .leading) {
                Text(media.name)
                    .foregroundColor(.primary)
                    .font(.callout)
                    .lineLimit(1)
                
                Text("\(media.kind.title) · \(media.artistName)")
                    .foregroundColor(.secondary)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
    }
}

//struct SearchResultsRowItem_Previews: PreviewProvider {
//    struct SearchResultsRowItemExample: View {
//        let media = MediaResponse(id: 0, name: "Placeholder", artistName: "Placeholder")
//        
//        var body: some View {
//            SearchResultsRowItem(media: media)
//        }
//    }
//    
//    static var previews: some View {
//        SearchResultsRowItemExample()
//    }
//}
