//
//  HighlightsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HighlightsView: View {
    @State var items = [LargePictureModel]()

    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    ForEach(items, id: \.self) { item in
                        VStack(spacing: 0) {
                            Divider()
                            Spacer()
                            Text(item.type.uppercased())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.secondary)
                                .font(.caption)
                            Text(item.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)
                            Text(item.description)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.secondary)
                                .font(.title3)
                            Spacer()
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width)
                                .cornerRadius(5)
                            Spacer()
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.38)
    }
}
