//
//  VerticalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct VerticalMediaGridView: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    @State var mediaItems = [Media]()
    
    var title: String
    var imageSize: SizeType
    var columns: [GridItem]
    var gridSpacing: CGFloat?
    
    init(mediaItems: [Media], title: String = "", imageSize: SizeType) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        
        switch imageSize {
        case .trackRowItem:
            columns = Array(repeating: .init(.flexible(), spacing: 8), count: 1)
            gridSpacing = 0
        case .albumCarouselItem, .videoCarouselItem:
            columns = Array(repeating: .init(.flexible(), spacing: 12), count: 2)
            gridSpacing = 12
        default:
            columns = Array(repeating: .init(.flexible(), spacing: 10), count: 2)
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
                    case .trackRowItem:
                        TrackMediaRow(media: media)
                    case .albumCarouselItem:
                        AlbumMediaItem(media: media)
                    case .videoCarouselItem:
                        VideoMediaRow(media: media)
                    default:
                        VideoMediaItem(media: media)
                    }
                    
                }
            }
            .padding(.horizontal)
            
            if playerObservableObject.showPlayerView, !playerObservableObject.expand {
                Spacer(minLength: Metric.playerHeight)
            }
        }
    }
}
