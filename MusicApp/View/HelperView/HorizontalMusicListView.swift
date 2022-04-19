//
//  HorizontalMusicListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HorizontalMusicListView: View {
    @State var items = [SmallPictureModel]()
    
    let rows: [GridItem] = Array(repeating: .init(.fixed(Metric.rowHeight)), count: 2)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        Image(item.image)
                            .resizable()
                            .frame(width: Metric.imageSize, height: Metric.imageSize, alignment: .leading)
                            .cornerRadius(6)
                        
                        Text(item.name)
                            .frame(maxWidth: Metric.imageSize, alignment: .leading)
                            .lineLimit(1)
                            .font(.subheadline)
                        
                        Text(item.description)
                            .frame(maxWidth: Metric.imageSize, alignment: .leading)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

extension HorizontalMusicListView {
    enum Metric {
        static let imageSize: CGFloat = 170
        static let rowHeight: CGFloat = 220
    }
}
