//
//  LibraryListDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import SwiftUI

struct LibraryListDetailView: View {
    @ObservedObject var libraryObservableObject: LibraryObservableObject
    var section: LibrarySection
    @State var sort: SortOrder = .forward
    @State private var searchTerm = ""
    
    var body: some View {
        ScrollView {
            Divider()
            
            switch section {
            case .playlists: VerticalMediaGridView(mediaItems: libraryObservableObject.playlists, imageSize: .medium, rowCount: 2)
            case .artists: VerticalMediaGridView(mediaItems: libraryObservableObject.artists, imageSize: .small, rowCount: 1)
            case .albums: VerticalMediaGridView(mediaItems: libraryObservableObject.albums, imageSize: .medium, rowCount: 2)
            case .songs: VerticalMediaGridView(mediaItems: libraryObservableObject.songs, imageSize: .small, rowCount: 1)
            case .madeForYou: VerticalMediaGridView(mediaItems: libraryObservableObject.madeForYou, imageSize: .medium, rowCount: 2)
            case .tvAndMovies: VerticalMediaGridView(mediaItems: libraryObservableObject.tvAndMovies, imageSize: .medium, rowCount: 2)
            case .musicVideos: VerticalMediaGridView(mediaItems: libraryObservableObject.musicVideos, imageSize: .medium, rowCount: 2)
            case .genres: VerticalMediaGridView(mediaItems: libraryObservableObject.genres, imageSize: .small, rowCount: 1)
            case .compilations: VerticalMediaGridView(mediaItems: libraryObservableObject.compilations, imageSize: .medium, rowCount: 2)
            case .composers: VerticalMediaGridView(mediaItems: libraryObservableObject.composers, imageSize: .small, rowCount: 1)
            case .downloaded: VerticalMediaGridView(mediaItems: libraryObservableObject.downloaded, imageSize: .medium, rowCount: 2)
            case .homeSharing: VerticalMediaGridView(mediaItems: libraryObservableObject.homeSharing, imageSize: .medium, rowCount: 2)
            }
            
            Spacer(minLength: Metric.playerHeight)
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
