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
    
    init(mediaItems: [Media], title: String = "", imageSize: ImageSizeType, rowCount: Int = 1) {
        self.mediaItems = mediaItems
        self.title = title
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            columns = Array(repeating: .init(.flexible(), spacing: 2, alignment: .leading), count: rowCount)
        case .medium:
            columns = Array(repeating: .init(.flexible()), count: rowCount)
        case .large:
            columns = Array(repeating: .init(.fixed(Metric.largeRowHeight)), count: rowCount)
        }
    }
    
    var body: some View {
        if !title.isEmpty {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(mediaItems, id: \.self) { media in
                    // FIXME: - Access media based on kind
                    switch media.wrapperType {
                    case .collection:
                        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
                            switch imageSize {
                            case .small:
                                SearchResultsRowItem(media: media)
                            case .medium:
                                MediumMediaRowItem(media: media)
                            case .large:
                                LargeMediaRowItem(media: media)
                            }
                        }
                        
                    case .track:
                        SearchResultsRowItem(media: media)
                            .onTapGesture {
                                guard media.wrapperType == .track else { return }
                                // FIXME: - Pass the player
                                MPMusicPlayerController.applicationMusicPlayer.setQueue(with: [media.id])
                                
                                MPMusicPlayerController.applicationMusicPlayer.play()
                                
                                hideKeyboard()
                            }
                    case .artist:
                        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: SearchObservableObject())) {
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
                }
                .padding(.horizontal)
            }
            
            Spacer(minLength: Metric.playerHeight)
        }
    }
}
