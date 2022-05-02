//
//  HorizontalMusicListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HorizontalMusicListView: View {
    @State var items = [SmallPictureModel]()
    var imageSize: ImageSizeType
    var gridRows: [GridItem]
    
    init(items: [SmallPictureModel], imageSize: ImageSizeType, rowCount: Int = 1) {
        self.items = items
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            gridRows = Array(repeating: .init(.fixed(Metric.smallRowHeight), spacing: 2), count: rowCount)
        case .medium:
            gridRows = Array(repeating: .init(.fixed(Metric.mediumRowHeight)), count: rowCount)
        case .large:
            gridRows = Array(repeating: .init(.fixed(Metric.largeRowHeight)), count: rowCount)
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows, spacing: 12) {
                ForEach(items, id: \.self) { item in
                    let media = Media(artistName: item.description, collectionName: item.name, trackName: item.name, description: item.description, artwork: Image(item.image))
                    
                    switch imageSize {
                    case .small:
                        SmallMediaRowItem(media: media)
                    case .medium:
                        MediumMediaRowItem(media: media)
                    case .large:
                        LargeMediaRowItem(media: media)
                    }
                }  
            }
            .padding([.horizontal])
        }
        
        Divider()
            .padding([.horizontal])
    }
}

struct HorizontalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMusicListView(items: musicPlaylists[0], imageSize: .medium, rowCount: 1)
    }
}
