//
//  BrowseView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct BrowseView: View {
    let title = "Browse"
    
    var detailViews: [DefaultView] {
        var detailsViews = [DefaultView]()
        for title in BrowseMoreToExplore.allCases {
            detailsViews.append(DefaultView(title: title.title))
        }
        
        return detailsViews
    }
    
    var body: some View {
        NavigationView {
            ScrollView() {
                Divider()
                
                HighlightsView(items: selectedStations, imageSize: .large)

                Text(title)
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HorizontalMediaGridView(items: musicPlaylists[2], imageSize: .small, rowCount: 4)
                
                NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews)

                Spacer(minLength: Metric.playerHeight)
            }
            .navigationTitle(title)
        }
    }
}
//
//struct BrowseView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrowseView()
//    }
//}

enum BrowseMoreToExplore: Int {
    case browseByCategory
    case topCharts
    case chill
    case essentials
    case kids
    case musicVideos
    
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
