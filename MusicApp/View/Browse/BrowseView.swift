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
                    .padding(.horizontal)
                
                HighlightsView(items: selectedStations, imageSize: .highlight)
                
                HorizontalMediaGridView(mediaItems: musicPlaylists, title: "New Music", imageSize: .track, rowCount: 4)
                
                NavigationLinkList(rowItems: BrowseMoreToExplore.self, content: detailViews)
                    .frame(height: 250)
                Spacer(minLength: Metric.playerHeight)
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
