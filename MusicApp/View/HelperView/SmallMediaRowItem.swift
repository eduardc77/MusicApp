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
                
                Image(uiImage: media.artwork ?? UIImage())
                    .resizable()
                    .frame(width: Metric.smallImageSize, height: Metric.smallImageSize)
                    .cornerRadius(4)
               
                VStack(alignment: .leading) {
                    Divider()
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        
                        VStack {
                            Text(media.trackName ?? "")
                                .foregroundColor(.primary)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                            
                            
                            Text(media.description ?? "")
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
        let media = Media(id: "", trackName: "Placeholder Name", artistName: "Placeholder Artist", description: "Placeholder Description", artwork: UIImage(named: "bigradio1"))
        
        var body: some View {
            SmallMediaRowItem(media: media)
        }
    }
    
    static var previews: some View {
        SmallMediaRowItemExample()
    }
}
