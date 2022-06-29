//
//  ListenNowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ListenNowView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                    .padding(.horizontal)
                
                VStack {
                    HighlightsView(items: selectedStations, imageSize: .highlight)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best New Songs", imageSize: .trackRowItem, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear", imageSize: .albumItem, rowCount: 1)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .trackRowItem, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .albumItem, rowCount: 2)
                }
                
                Spacer(minLength: Metric.playerBarHeight)
            }
            .toolbar(content: {
                AccountNavigationItem()
            })
            
            .navigationTitle("Listen Now")
        }
    }
}


struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
