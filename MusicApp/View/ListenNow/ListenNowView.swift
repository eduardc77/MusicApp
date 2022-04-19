//
//  ListenNowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ListenNowView: View {
    let title = "Listen Now"
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                HighlightsView(items: selectedStatiions)

                Text(title)
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VerticalMusicListView(items: radioStations)
            }
//            .padding(.bottom, Metric.playerHeight)
            .navigationTitle(title)
        }
    }
}

extension ListenNowView {
    enum Metric {
        static let playerHeight: CGFloat = 80
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
