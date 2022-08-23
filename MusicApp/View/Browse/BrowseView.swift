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
    NavigationView {
      ScrollView() {
        HighlightsView(items: selectedStations, imageSize: .highlight)

        HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .trackRowItem, rowCount: 4)

        NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews, title: "More to Explore")

        if playerObservableObject.showPlayerView, !playerObservableObject.expand {
          Spacer(minLength: Metric.playerHeight)
        }
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


struct BrowseView_Previews: PreviewProvider {
  static var previews: some View {
    BrowseView()
  }
}
