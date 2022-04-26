//
//  BrowseView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct BrowseView: View {
    let title = "Browse"
    
    var body: some View {
        NavigationView {
            ScrollView() {
                Divider()
                HighlightsView(items: selectedStations, imageSize: .large)

                Text(title)
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HorizontalMusicListView(items: musicPlaylists[2], imageSize: .small, rowCount: 4)
                Spacer(minLength: Metric.playerHeight)
            }
            .navigationTitle(title)
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
