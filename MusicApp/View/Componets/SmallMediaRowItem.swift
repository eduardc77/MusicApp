//
//  SmallMediaRowItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 25.04.2022.
//

import SwiftUI

struct SmallMediaRowItem: View {
    var media: Media
    var imageData: Data?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                MediaImageView(image: media.artwork, size: Size(width: Metric.smallImageSize, height: Metric.smallImageSize))
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        
                        VStack {
                            Text(media.trackName ?? media.collectionName ?? media.artistName ?? "")
                                .foregroundColor(.primary)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            
                            
                            Text(media.artistName ?? media.description ?? media.composer ?? media.country ?? "")
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                        }
                        Image(systemName: "ellipsis")
                            .padding(.trailing)
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 34)
    }
}




struct SmallMediaRowItem_Previews: PreviewProvider {
    struct SmallMediaRowItemExample: View {
        let media = Media(artistName: "Placeholder Artist", trackName: "Placeholder Name", description: "Placeholder Description", artwork: Image("bigradio1"))
        
        var body: some View {
            SmallMediaRowItem(media: media)
        }
    }
    
    static var previews: some View {
        SmallMediaRowItemExample()
    }
}
