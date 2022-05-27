//
//  HighlightsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HighlightsView: View {
    @State var items = [LargePictureModel]()
    @State var currentIndex: Int = 0
    
    var imageSize: SizeType
    var rowCount: Int = 1
    var gridRows: [GridItem]
    
    init(items: [LargePictureModel], imageSize: SizeType, rowCount: Int = 1) {
        self.items = items
        self.imageSize = imageSize
        
        switch imageSize {
        case .trackRowItem:
            gridRows = Array(repeating: .init(.fixed(Metric.trackRowItemHeight)), count: rowCount)
        case .albumItem:
            gridRows = Array(repeating: .init(.fixed(Metric.albumRowItemHeight)), count: rowCount)
        case .highlight:
            gridRows = Array(repeating: .init(.fixed(Metric.highlightCarouselItemHeight)), count: rowCount)
        default: gridRows = Array(repeating: .init(.fixed(Metric.albumRowItemHeight)), count: rowCount)
        }
    }
    
    var body: some View {
        TabView {
            ForEach(items, id: \.self) { item in
                
                let media = Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: nil, collectionId: nil, trackId: nil, wrapperType: WrapperType.collection.rawValue, kind: MediaKind.podcast.rawValue, name: item.name, artistName: item.description, collectionName: "podcast", trackName: item.description, collectionCensoredName: nil, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: nil, trackPrice: nil, collectionExplicitness: nil, trackExplicitness: nil, discCount: nil, discNumber: nil, trackCount: nil, trackNumber: nil, trackTimeMillis: nil, country: nil, currency: nil, primaryGenreName: nil, description: nil, longDescription: nil, releaseDate: nil, contentAdvisoryRating: nil, trackRentalPrice: nil, artwork: UIImage(named: item.image), composer: nil, isCompilation: nil, dateAdded: nil))
                
                switch imageSize {
                case .trackRowItem:
                    TrackMediaRow(media: media)
                case .albumItem:
                    AlbumMediaItem(media: media)
                case .highlight:
                    HighlightMediaItem(media: media)
                default: AlbumMediaItem(media: media)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: Metric.highlightCarouselItemHeight)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
        Divider()
            .padding(.horizontal)
    }
}


struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView(items: selectedStations, imageSize: .musicVideoItem)
    }
}
