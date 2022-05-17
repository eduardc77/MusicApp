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
    var imageSize: ImageSizeType
    var gridRows: [GridItem]
    var maxHighlightShowing: Int
    
    init(mediaItems: [Media], title: String = "", imageSize: ImageSizeType, rowCount: Int = 1, maxHighlightShowing: Int = 8) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        self.maxHighlightShowing = maxHighlightShowing
        
        switch imageSize {
        case .small:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.smallRowItemHeight), spacing: 0), count: rowCount)
        case .medium:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.mediumRowItemHeight), spacing: 10), count: rowCount)
        case .large:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.largeRowItemHeight), spacing: 8), count: rowCount)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if !title.isEmpty {
                HStack {
                    Text(title)
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if mediaItems.count > maxHighlightShowing {
                        NavigationLink {
                            switch mediaItems.first?.kind {
                            case .album, .musicVideo:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .medium, rowCount: 2)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            case .song:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .small, rowCount: 1)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            case .artist:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .small, rowCount: 1)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            default:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .small, rowCount: 1)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            }
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
                        case .small:
                            SmallMediaRow(media: media)
                        case .medium:
                            MediumMediaItem(media: media)
                        case .large:
                            LargeMediaItem(media: media)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer(minLength: 8)
            
            Divider()
                .padding(.horizontal)
        }
    }
}

struct HorizontalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear This", imageSize: .medium, rowCount: 1)
    }
}
