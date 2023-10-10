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
      NavigationStack {
         ScrollView {
            VStack(spacing: 30) {
               HorizontalMediaGridView(mediaItems: highlightContent(), imageSize: .highlightCarouselItem, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Recently Played", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Top Picks", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .trackRowItem, rowCount: 4, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Chill", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Made for You", imageSize: .trackRowItem, rowCount: 4, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "New Releases", imageSize: .albumCarouselItem, rowCount: 2, scrollBehavior: .paging)
            }
            
            if playerObservableObject.showPlayerView, !playerObservableObject.expand { Spacer(minLength: Metric.playerHeight) }
         }
         .toolbar { AccountNavigationItem() }
         .navigationTitle("Listen Now")
      }
   }
}


// MARK: - Previews

struct ListenNowView_Previews: PreviewProvider {
   static var previews: some View {
      ListenNowView()
         .environmentObject(PlayerObservableObject())
   }
}
