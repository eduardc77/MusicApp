//
//  AlbumDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
    @StateObject private var mediaItemObservableObject: MediaItemObservableObject
    
    init(media: Media, searchObservableObject: SearchObservableObject) {
        _mediaItemObservableObject = StateObject(wrappedValue: MediaItemObservableObject(media: media, searchObservableObject: searchObservableObject))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AlbumHeaderView(albumDetailObservableObject: mediaItemObservableObject)
                
                AlbumTrackList(albumDetailObservableObject: mediaItemObservableObject)
                
                Spacer(minLength: Metric.playerHeight)
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
