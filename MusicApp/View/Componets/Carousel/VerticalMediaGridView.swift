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
    var imageSize: SizeType
    var columns: [GridItem]
    var gridSpacing: CGFloat?
    
    init(mediaItems: [Media], title: String = "", imageSize: SizeType, rowCount: Int = 1) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        
        switch imageSize {
        case .track:
            columns = Array(repeating: .init(.flexible()), count: rowCount)
            gridSpacing = 0
        case .album, .musicVideoItem:
            columns = Array(repeating: .init(.flexible(), spacing: 12), count: rowCount)
            gridSpacing = 12
        default:
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
                    switch imageSize {
                    case .track:
                        TrackMediaRow(media: media)
                    case .album:
                        AlbumMediaItem(media: media)
                    case .musicVideoRow:
                        VideoMediaRow(media: media)
                    default:
                        VideoMediaItem(media: media)
                    }
                    
                }
            }
            .padding(.horizontal)
            
            Spacer(minLength: Metric.playerHeight)
        }
    }
}
