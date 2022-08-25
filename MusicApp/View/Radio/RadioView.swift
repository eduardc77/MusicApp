//
//  RadioView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct RadioView: View {
  @EnvironmentObject private var playerObservableObject: PlayerObservableObject
  
  var body: some View {
    NavigationView {
      ScrollView {
        HighlightsView(items: selectedStations, imageSize: .highlight)
        
        HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Our Radio Hosts", imageSize: .albumCarouselItem)
        
        HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Episodes", imageSize: .trackRowItem, rowCount: 4)
        
        if playerObservableObject.showPlayerView, !playerObservableObject.expand {
          Spacer(minLength: Metric.playerHeight)
        }
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
