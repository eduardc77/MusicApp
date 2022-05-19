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
            switch section {
            case .playlists: VerticalMediaGridView(mediaItems: libraryObservableObject.playlists, imageSize: .album, rowCount: 2)
            case .artists: VerticalMediaGridView(mediaItems: libraryObservableObject.artists, imageSize: .track, rowCount: 1)
            case .albums: VerticalMediaGridView(mediaItems: libraryObservableObject.albums, imageSize: .album, rowCount: 2)
            case .songs: VerticalMediaGridView(mediaItems: libraryObservableObject.songs, imageSize: .track, rowCount: 1)
            case .madeForYou: VerticalMediaGridView(mediaItems: libraryObservableObject.madeForYou, imageSize: .album, rowCount: 2)
            case .tvAndMovies: VerticalMediaGridView(mediaItems: libraryObservableObject.tvAndMovies, imageSize: .album, rowCount: 2)
            case .musicVideos: VerticalMediaGridView(mediaItems: libraryObservableObject.musicVideos, imageSize: .album, rowCount: 2)
            case .genres: VerticalMediaGridView(mediaItems: libraryObservableObject.genres, imageSize: .track, rowCount: 1)
            case .compilations: VerticalMediaGridView(mediaItems: libraryObservableObject.compilations, imageSize: .album, rowCount: 2)
            case .composers: VerticalMediaGridView(mediaItems: libraryObservableObject.composers, imageSize: .track, rowCount: 1)
            case .downloaded: VerticalMediaGridView(mediaItems: libraryObservableObject.downloaded, imageSize: .album, rowCount: 2)
            case .homeSharing: VerticalMediaGridView(mediaItems: libraryObservableObject.homeSharing, imageSize: .album, rowCount: 2)
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
