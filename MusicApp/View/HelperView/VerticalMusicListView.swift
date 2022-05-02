//
//  VerticalMusicListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VerticalMusicListView: View {
    @State var mediaItems = [Media]()
    var imageSize: ImageSizeType
    var columns: [GridItem]
    
    init(mediaItems: [Media], imageSize: ImageSizeType, rowCount: Int = 1) {
        self.mediaItems = mediaItems
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            columns = Array(repeating: .init(.fixed(Metric.smallRowHeight), spacing: 2), count: rowCount)
        case .medium:
            columns = Array(repeating: .init(.flexible()), count: rowCount)
        case .large:
            columns = Array(repeating: .init(.fixed(Metric.largeRowHeight)), count: rowCount)
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(mediaItems, id: \.self) { media in
                    NavigationLink(destination: AlbumDetailView(media: media)) {
                        switch imageSize {
                        case .small:
                            SearchResultsRowItem(media: media)
                        case .medium:
                            MediumMediaRowItem(media: media)
                        case .large:
                            LargeMediaRowItem(media: media)
                        }
                    }
                }
            }.padding([.horizontal, .bottom])
        }
    }
}
