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
                    HighlightsView(items: selectedStations, imageSize: .large)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best New Songs", imageSize: .small, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear", imageSize: .medium, rowCount: 1)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .small, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .medium, rowCount: 2)
                }
                
                Spacer(minLength: Metric.playerHeight)
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
