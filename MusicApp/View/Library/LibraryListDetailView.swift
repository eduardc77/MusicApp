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
            case .playlists:
                VerticalMusicListView(mediaItems: libraryObservableObject.playlists, imageSize: .medium, rowCount: 2)
            case .artists:
                VerticalMusicListView(mediaItems: libraryObservableObject.artists, imageSize: .small, rowCount: 1)
            case .albums:
                VerticalMusicListView(mediaItems: libraryObservableObject.albums, imageSize: .medium, rowCount: 2)
            case .songs:
                VerticalMusicListView(mediaItems: libraryObservableObject.songs, imageSize: .small, rowCount: 1)
            case .madeForYou:
                VerticalMusicListView(mediaItems: libraryObservableObject.madeForYou, imageSize: .medium, rowCount: 2)
            case .tvAndMovies:
                VerticalMusicListView(mediaItems: libraryObservableObject.tvAndMovies, imageSize: .medium, rowCount: 2)
            case .musicVideos:
                VerticalMusicListView(mediaItems: libraryObservableObject.musicVideos, imageSize: .medium, rowCount: 2)
            case .genres:
                VerticalMusicListView(mediaItems: libraryObservableObject.genres, imageSize: .small, rowCount: 1)
            case .compilations:
                VerticalMusicListView(mediaItems: libraryObservableObject.compilations, imageSize: .medium, rowCount: 2)
            case .composers:
                VerticalMusicListView(mediaItems: libraryObservableObject.composers, imageSize: .small, rowCount: 1)
            case .downloaded:
                VerticalMusicListView(mediaItems: libraryObservableObject.downloaded, imageSize: .medium, rowCount: 2)
            case .homeSharing:
                VerticalMusicListView(mediaItems: libraryObservableObject.homeSharing, imageSize: .medium, rowCount: 2)
            }

            Spacer(minLength: Metric.playerHeight)
        }
        .navigationTitle(section.title)
        .searchable(text: $searchTerm, prompt: "Find in \(section.title)")
        .toolbar {
            Button(action: {}, label:
            { Text("Sort") })
        }
    }
}

struct LibraryListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryListDetailView(libraryObservableObject: LibraryObservableObject(), section: .albums)
    }
}





