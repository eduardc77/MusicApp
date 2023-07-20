//
//  BrowseView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct BrowseView: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   let title = "Browse"
   
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
            HighlightsView(items: selectedStations, imageSize: .highlightCarouselItem)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "You Gotta Hear", imageSize: .albumCarouselItem)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Now in Spatial Audio", imageSize: .trackRowItem, rowCount: 4)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "New Music", imageSize: .albumCarouselItem, rowCount: 2)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Essentials", imageSize: .albumCarouselItem)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Best New Songs", imageSize: .trackRowItem, rowCount: 4)
            
            HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Coming Soon", imageSize: .albumCarouselItem)
            
            NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews, title: "More to Explore")
            
            if playerObservableObject.showPlayerView, !playerObservableObject.expand { Spacer(minLength: Metric.playerHeight) }
         }
         .navigationTitle(title)
      }
   }
}

enum BrowseMoreToExplore: Int {
   case browseByCategory
   case topCharts
   case chill
   case essentials
   case kids
   case musicVideos
}

extension BrowseMoreToExplore: Nameable {
   var title: String {
      switch self {
      case .browseByCategory:
         return "Browse By Category"
      case .topCharts:
         return "Top Charts"
      case .chill:
         return "Chill"
      case .essentials:
         return "Essentials"
      case .kids:
         return "Kids"
      case .musicVideos:
         return "Music Videos"
      }
   }
}

extension BrowseMoreToExplore: CaseIterable, Identifiable, Hashable {
   var id: String {
      UUID().uuidString
   }
}


// MARK: - Previews

struct BrowseView_Previews: PreviewProvider {
   static var previews: some View {
      BrowseView()
         .environmentObject(PlayerObservableObject())
   }
}
