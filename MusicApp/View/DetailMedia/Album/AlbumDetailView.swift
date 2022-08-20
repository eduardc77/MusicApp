//
//  AlbumDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    @StateObject private var mediaItemObservableObject: LibraryMediaItemObservableObject
    
    init(media: Media, searchObservableObject: SearchObservableObject) {
        _mediaItemObservableObject = StateObject(wrappedValue: LibraryMediaItemObservableObject(media: media, searchObservableObject: searchObservableObject))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AlbumHeaderView(libraryMediaObservableObject: mediaItemObservableObject)
                
                if mediaItemObservableObject.media.collectionId == 0 {
                    LibraryAlbumTrackList(libraryMediaObservableObject: mediaItemObservableObject)
                } else {
                    AlbumTrackList(media: mediaItemObservableObject.media)
                }
                
                if playerObservableObject.showPlayerView {
                    Spacer(minLength: Metric.playerHeight)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .toolbar {
            HStack {
                Button { } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(Color.appAccentColor, Color.secondary.opacity(0.16))
                }
                
                Button{ } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(Color.appAccentColor, Color.secondary.opacity(0.16))
                }
            }
        }
    }
}
