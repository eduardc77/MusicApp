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
    
    private var maxHighlightShowing = 32
    
    init(mediaItems: [Media], title: String = "", imageSize: ImageSizeType, rowCount: Int = 1) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            gridRows = Array(repeating: .init(.fixed(Metric.smallRowHeight), spacing: 2), count: rowCount)
        case .medium:
            gridRows = Array(repeating: .init(.fixed(Metric.mediumRowHeight), spacing: 10), count: rowCount)
        case .large:
            gridRows = Array(repeating: .init(.fixed(Metric.largeRowHeight)), count: rowCount)
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
                                // All types of see all - Review
                            case .album:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .medium, rowCount: 2)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            default:
                                VerticalMediaGridView(mediaItems: mediaItems, imageSize: .medium, rowCount: 1)
                                    .navigationTitle(title)
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                        } label: {
                            Text("See All")
                                .font(.body)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, spacing: 12) {
                    ForEach(mediaItems.prefix(maxHighlightShowing), id: \.self) { media in
                        
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
                .padding(.horizontal)
            }
            
            Spacer(minLength: 8)
            Divider()
        }
    }
}

struct HorizontalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear This", imageSize: .medium, rowCount: 1)
    }
}
