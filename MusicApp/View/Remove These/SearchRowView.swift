//
//  SearchRowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchRowView: View {
    var item: SmallPictureModel
    var body: some View {
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
        }
    }
}

extension SearchRowView {
    enum Metric {
        static let imageSize: CGFloat = 100
    }
}
