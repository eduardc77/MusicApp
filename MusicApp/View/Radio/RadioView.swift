//
//  RadioView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct RadioView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                    .padding(.horizontal)
                
                HighlightsView(items: selectedStations, imageSize: .large)
                
                HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Our Radio Hosts", imageSize: .medium)
                
                HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Episodes", imageSize: .small, rowCount: 4)
                
                Spacer(minLength: Metric.playerHeight)
            }
            .navigationTitle("Radio")
        }
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView()
    }
}
