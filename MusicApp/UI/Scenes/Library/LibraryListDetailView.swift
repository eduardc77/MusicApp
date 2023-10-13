//
//  LibraryListDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import SwiftUI

struct LibraryListDetailView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var libraryModel: LibraryModel
   @State var sort: SortOrder = .forward
   @State private var searchTerm = ""
   
   var section: LibrarySection
   
   var body: some View {
      ScrollView {
         switch section {
            case .playlists: VerticalMediaGridView(mediaItems: libraryModel.playlists, imageSize: .albumCarouselItem)
            case .artists: VerticalMediaGridView(mediaItems: libraryModel.artists, imageSize: .trackRowItem)
            case .albums: VerticalMediaGridView(mediaItems: libraryModel.albums, imageSize: .albumCarouselItem)
            case .songs: VerticalMediaGridView(mediaItems: libraryModel.songs, imageSize: .trackRowItem)
            case .madeForYou: VerticalMediaGridView(mediaItems: libraryModel.madeForYou, imageSize: .albumCarouselItem)
            case .tvAndMovies: VerticalMediaGridView(mediaItems: libraryModel.tvAndMovies, imageSize: .albumCarouselItem)
            case .musicVideos: VerticalMediaGridView(mediaItems: libraryModel.musicVideos, imageSize: .albumCarouselItem)
            case .genres: VerticalMediaGridView(mediaItems: libraryModel.genres, imageSize: .trackRowItem)
            case .compilations: VerticalMediaGridView(mediaItems: libraryModel.compilations, imageSize: .albumCarouselItem)
            case .composers: VerticalMediaGridView(mediaItems: libraryModel.composers, imageSize: .trackRowItem)
            case .downloaded: VerticalMediaGridView(mediaItems: libraryModel.downloaded, imageSize: .albumCarouselItem)
            case .homeSharing: VerticalMediaGridView(mediaItems: libraryModel.homeSharing, imageSize: .albumCarouselItem)
         }
         
         if playerModel.showPlayerView, !playerModel.expand {
            Spacer(minLength: Metric.playerHeight)
         }
      }
      .navigationTitle(section.title)
      .searchable(text: $searchTerm, prompt: "Find in \(section.title)")
      
      .toolbar {
         Button("Sort") {
            
         }
      }
   }
}


// MARK: - Previews

struct LibraryListDetailView_Previews: PreviewProvider {
   static var previews: some View {
      LibraryListDetailView(libraryModel: LibraryModel(), section: .albums)
         .environmentObject(PlayerModel())
   }
}
