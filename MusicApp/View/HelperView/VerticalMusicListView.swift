//
//  VerticalMusicListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VerticalMusicListView: View {
    
    @State var items = [SmallPictureModel]()
    
    var columns = [
        GridItem(.flexible(), alignment: .leading)
        ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(items, id: \.self) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .frame(width: Metric.imageSize, height: Metric.imageSize, alignment: .leading)
                        .cornerRadius(5)
                    VStack {
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                        Text(item.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                Divider()
            }
            .padding(.horizontal)
        }
    }
}
