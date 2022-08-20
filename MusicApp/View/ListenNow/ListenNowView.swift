//
//  ListenNowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ListenNowView: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HighlightsView(items: selectedStations, imageSize: .highlight)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best New Songs", imageSize: .trackRowItem, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear", imageSize: .albumCarouselItem, rowCount: 1)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .trackRowItem, rowCount: 4)
                    
                    HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .albumCarouselItem, rowCount: 2)
                }
                
                if playerObservableObject.showPlayerView {
                    Spacer(minLength: Metric.playerHeight)
                }
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
