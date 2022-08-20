//
//  HorizontalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HorizontalMediaGridView: View {
    @State var mediaItems = [Media]()
    var title: String
    var imageSize: SizeType
    var gridRows: [GridItem]
    var maxHighlightShowing: Int
    
    init(mediaItems: [Media], title: String = "", imageSize: SizeType, rowCount: Int = 1, maxHighlightShowing: Int = 8) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        self.maxHighlightShowing = maxHighlightShowing
        
        switch imageSize {
        case .trackRowItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.trackRowItemHeight), spacing: 0), count: rowCount)
        case .albumCarouselItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumRowItemHeight), spacing: 8), count: rowCount)
        case .videoCarouselItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.largeRowItemHeight), spacing: 8), count: rowCount)
        default:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumRowItemHeight), spacing: 10), count: rowCount)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Divider()
                .padding(.horizontal)
            
            if !title.isEmpty {
                HStack {
                    Text(title)
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if mediaItems.count > maxHighlightShowing {
                        NavigationLink {
                            VerticalMediaGridView(mediaItems: mediaItems, imageSize: imageSize)
                                .navigationTitle(title)
                                .navigationBarTitleDisplayMode(.inline)
                            
                        } label: {
                            Text("See All")
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, spacing: 12) {
                    ForEach(mediaItems.prefix(maxHighlightShowing), id: \.id) { media in
                        
                        switch imageSize {
                        case .trackRowItem:
                            TrackMediaRow(media: media)
                        case .albumCarouselItem:
                            AlbumMediaItem(media: media)
                        case .videoCarouselItem:
                            VideoMediaItem(media: media)
                        default: AlbumMediaItem(media: media)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer(minLength: 8)
        }
    }
}

struct HorizontalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear This", imageSize: .albumCarouselItem, rowCount: 1)
    }
}
