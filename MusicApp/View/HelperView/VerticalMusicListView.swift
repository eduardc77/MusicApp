//
//  VerticalMusicListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VerticalMusicListView: View {
    @State var items = [SmallPictureModel]()
    var imageSize: ImageSizeType
    
    var columns = [
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(items, id: \.self) { item in
                    let media = Media(id: "", trackName: item.name, artistName: item.description, description: item.description, artwork: Image(item.image))
                    Divider()
                    switch imageSize {
                    case .small:
                        SearchResultsRowItem(media: media)
                    case .medium:
                        MediumMediaRowItem(media: media)
                    case .large:
                        LargeMediaRowItem(media: media)
                    }
                    
                }
                
            }.padding([.horizontal, .bottom])
        }
    }
}
