//
//  VerticalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct VerticalMediaGridView: View {
    @State var mediaItems = [Media]()
    
    var title: String
    var imageSize: ImageSizeType
    var columns: [GridItem]
    var gridSpacing: CGFloat?
    
    init(mediaItems: [Media], title: String = "", imageSize: ImageSizeType, rowCount: Int = 1) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            columns = Array(repeating: .init(.flexible(), alignment: .leading), count: rowCount)
            gridSpacing = 0
        case .medium, .large:
            columns = Array(repeating: .init(.flexible(), spacing: 10), count: rowCount)
            gridSpacing = 12
        }
    }
    
    var body: some View {
        if !title.isEmpty {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: gridSpacing) {
                ForEach(Array(zip(mediaItems.indices, mediaItems)), id: \.0) { _, media in
                    switch media.wrapperType {
                    case .collection:
                        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
                            switch imageSize {
                            case .small:
                                SmallMediaRow(media: media)
                            case .medium:
                                MediumMediaItem(media: media)
                            case .large:
                                LargeMediaItem(media: media)
                            }
                        }
                        
                    case .track:
                        SmallMediaRow(media: media)
                           
                    case .artist:
                        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
                            switch imageSize {
                            case .small:
                                SmallMediaRow(media: media)
                            case .medium:
                                MediumMediaItem(media: media)
                            case .large:
                                LargeMediaItem(media: media)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer(minLength: Metric.playerHeight)
        }
    }
}
