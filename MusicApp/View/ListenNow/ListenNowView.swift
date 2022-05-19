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
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best New Songs", imageSize: .track, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear", imageSize: .album, rowCount: 1)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .track, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .album, rowCount: 2)
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
