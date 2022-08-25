//
//  LibraryListDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import SwiftUI

struct LibraryListDetailView: View {
  @EnvironmentObject private var playerObservableObject: PlayerObservableObject
  @ObservedObject var libraryObservableObject: LibraryObservableObject
  var section: LibrarySection
  @State var sort: SortOrder = .forward
  @State private var searchTerm = ""
  
  var body: some View {
    ScrollView {
      switch section {
      case .playlists: VerticalMediaGridView(mediaItems: libraryObservableObject.playlists, imageSize: .albumCarouselItem)
      case .artists: VerticalMediaGridView(mediaItems: libraryObservableObject.artists, imageSize: .trackRowItem)
      case .albums: VerticalMediaGridView(mediaItems: libraryObservableObject.albums, imageSize: .albumCarouselItem)
      case .songs: VerticalMediaGridView(mediaItems: libraryObservableObject.songs, imageSize: .trackRowItem)
      case .madeForYou: VerticalMediaGridView(mediaItems: libraryObservableObject.madeForYou, imageSize: .albumCarouselItem)
      case .tvAndMovies: VerticalMediaGridView(mediaItems: libraryObservableObject.tvAndMovies, imageSize: .albumCarouselItem)
      case .musicVideos: VerticalMediaGridView(mediaItems: libraryObservableObject.musicVideos, imageSize: .albumCarouselItem)
      case .genres: VerticalMediaGridView(mediaItems: libraryObservableObject.genres, imageSize: .trackRowItem)
      case .compilations: VerticalMediaGridView(mediaItems: libraryObservableObject.compilations, imageSize: .albumCarouselItem)
      case .composers: VerticalMediaGridView(mediaItems: libraryObservableObject.composers, imageSize: .trackRowItem)
      case .downloaded: VerticalMediaGridView(mediaItems: libraryObservableObject.downloaded, imageSize: .albumCarouselItem)
      case .homeSharing: VerticalMediaGridView(mediaItems: libraryObservableObject.homeSharing, imageSize: .albumCarouselItem)
      }
      
      if playerObservableObject.showPlayerView, !playerObservableObject.expand {
        Spacer(minLength: Metric.playerHeight)
      }
    }
    .navigationTitle(section.title)
    .searchable(text: $searchTerm, prompt: "Find in \(section.title)")
    
    .toolbar {
      Button("Sort") {
        print("Sort button tapped!")
      }
    }
  }
}


struct LibraryListDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LibraryListDetailView(libraryObservableObject: LibraryObservableObject(), section: .albums)
  }
}
