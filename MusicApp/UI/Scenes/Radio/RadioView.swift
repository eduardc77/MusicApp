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
		NavigationView {
			ScrollView {
				VStack {
					HighlightsView(items: selectedStations, imageSize: .highlightCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Recently Played", imageSize: .albumCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "New Episodes", imageSize: .albumRow, rowCount: 3)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Our Radio Hosts", imageSize: .albumCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Hosted by Artists", imageSize: .albumCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Discover New Shows", imageSize: .albumCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Apple Music 1", imageSize: .albumCarouselItem)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Local Broadcasters", imageSize: .albumRow, rowCount: 3)
					
					HorizontalMediaGridView(mediaItems: musicPlaylists, title: "International Broadcasters", imageSize: .albumRow, rowCount: 3)
					
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