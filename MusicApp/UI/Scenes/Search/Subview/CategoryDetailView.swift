//
//  CategoryDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct CategoryDetailView: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   var category: SearchCategoryModel
   
   var body: some View {
      ScrollView(.vertical, showsIndicators: true) {
         VStack() {
            Text(category.title)
               .font(.largeTitle).bold()
               .lineLimit(2)
               .frame(maxWidth: .infinity, alignment: .leading)
               .padding(.horizontal)
            
            VStack {
               HighlightsView(items: selectedMusic[category.tag], imageSize: .highlightCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best \(category.title) Music", imageSize: .albumCarouselItem, rowCount: 2)
               
               
               HighlightsView(items: selectedStations, imageSize: .highlightCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Recently Played", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Top Picks", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Stations for You", imageSize: .trackRowItem, rowCount: 4)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Chill", imageSize: .albumCarouselItem)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "Made for You", imageSize: .trackRowItem, rowCount: 4)
               
               HorizontalMediaGridView(mediaItems: musicPlaylists2, title: "New Releases", imageSize: .albumCarouselItem, rowCount: 2)
            }
         }
         .navigationBarTitleDisplayMode(.inline)
         
         if playerObservableObject.showPlayerView, !playerObservableObject.expand {
            Spacer(minLength: Metric.playerHeight)
         }
      }
      
   }
}


// MARK: - Previews

struct SearchDetailView_Previews: PreviewProvider {
   static var previews: some View {
      CategoryDetailView(category: searchCategories[0])
         .environmentObject(PlayerObservableObject())
   }
}

