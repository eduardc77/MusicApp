//
//  RadioView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct RadioView: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   
   var detailViews: [CategoryDetailView] {
      var detailsViews = [CategoryDetailView]()
      for browseSection in BrowseMoreToExplore.allCases {
         detailsViews.append(CategoryDetailView(category: SearchCategoryModel(image: "category\(browseSection.rawValue)", title: browseSection.title, tag: browseSection.rawValue)))
      }
      
      return detailsViews
   }
   
   var body: some View {
      NavigationStack {
         ScrollView {
            VStack(spacing: 30) {
               HorizontalMediaGridView(mediaItems: highlightContent(), imageSize: .highlightCarouselItem, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Recently Played", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "New Episodes", imageSize: .stationRow, rowCount: 3, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Our Radio Hosts", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Hosted by Artists", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Discover New Shows", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Apple Music 1", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Local Broadcasters", imageSize: .stationRow, rowCount: 3, scrollBehavior: .paging)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "International Broadcasters", imageSize: .stationRow, rowCount: 3, scrollBehavior: .paging)
               
               NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews, title: "More to Explore")
            }
     
            if playerObservableObject.showPlayerView, !playerObservableObject.expand { Spacer(minLength: Metric.playerHeight) }
         }
         .navigationTitle("Radio")
      }
   }
}


// MARK: - Previews

struct RadioView_Previews: PreviewProvider {
   static var previews: some View {
      RadioView()
         .environmentObject(PlayerObservableObject())
   }
}
