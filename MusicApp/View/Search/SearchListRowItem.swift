//
//  SearchListRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchListRowItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        HStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                MediaImageView(image: Image(uiImage: uiImage), cornerRadius: Metric.searchResultCornerRadius)
            } else {
                MediaImageView()
            }
            
            VStack(alignment: .leading) {
                Text(media.trackName ?? "")
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
