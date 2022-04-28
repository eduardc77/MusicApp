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
            gridRows = Array(repeating: .init(.fixed(Metric.largeRowHeight)), count: rowCount)
        }
        
    }
    
    var body: some View {
        TabView {
            ForEach(items, id: \.self) { item in
                    let media = Media(id: "", artistName: item.description, description: item.description, kind: MediaKind(rawValue: item.type), artwork: Image(item.image), collectionName: item.name)
                    
                    switch imageSize {
                    case .small:
                        SmallMediaRowItem(media: media)
                    case .medium:
                        MediumMediaRowItem(media: media)
                    case .large:
                        LargeMediaRowItem(media: media)
                    }
                    
                
            }
            .padding(.horizontal)
        }
        .frame(height: Metric.largeRowHeight)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.bottom)
        
        Divider()
            .padding(.horizontal)
        
    }
    
}


struct HighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightsView(items: selectedStations, imageSize: .large)
    }
}
