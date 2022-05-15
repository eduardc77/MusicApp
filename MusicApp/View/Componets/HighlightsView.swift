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
    
    var imageSize: ImageSizeType
    var rowCount: Int = 1
    var gridRows: [GridItem]
    
    init(items: [LargePictureModel], imageSize: ImageSizeType, rowCount: Int = 1) {
        self.items = items
        self.imageSize = imageSize
        
        switch imageSize {
        case .small:
            gridRows = Array(repeating: .init(.fixed(Metric.smallRowHeight)), count: rowCount)
        case .medium:
            gridRows = Array(repeating: .init(.fixed(Metric.mediumRowHeight)), count: rowCount)
        case .large:
            gridRows = Array(repeating: .init(.fixed(Metric.highlightsRowHeight)), count: rowCount)
        }
    }
    
    var body: some View {
        TabView {
            ForEach(items, id: \.self) { item in
                
                let media = Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: nil, collectionId: nil, trackId: nil, wrapperType: WrapperType.collection.rawValue, kind: MediaKind.podcast.rawValue, name: item.name, artistName: item.description, collectionName: "podcast", trackName: item.description, collectionCensoredName: nil, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: nil, trackPrice: nil, collectionExplicitness: nil, trackExplicitness: nil, discCount: nil, discNumber: nil, trackCount: nil, trackNumber: nil, trackTimeMillis: nil, country: nil, currency: nil, primaryGenreName: nil, description: nil, longDescription: nil, releaseDate: nil, contentAdvisoryRating: nil, trackRentalPrice: nil, artwork: UIImage(named: item.image), composer: nil, isCompilation: nil, dateAdded: nil))
                
                switch imageSize {
                case .small:
                    SmallMediaRowItem(media: media)
                case .medium:
                    MediumMediaRowItem(media: media)
                case .large:
                    HighlightMediaRowItem(media: media)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: Metric.highlightsRowHeight)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
        Divider()
            .padding(.horizontal)
    }
}


struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView(items: selectedStations, imageSize: .large)
    }
}
