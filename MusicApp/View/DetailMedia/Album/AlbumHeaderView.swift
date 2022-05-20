//
//  AlbumHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumHeaderView: View {
    @ObservedObject var albumDetailObservableObject: LibraryMediaItemObservableObject
    
    var body: some View {
        VStack {
            VStack {
                if let uiImage = albumDetailObservableObject.media.artwork {
                    MediaImageView(artworkImage: uiImage, size: Size(width: Metric.albumDetailImageSize, height: Metric.albumDetailImageSize), shadowProminence: .full)
                } else {
                    MediaImageView(imagePath: albumDetailObservableObject.media.artworkPath.resizedPath(size: 800), size: Size(width: Metric.albumDetailImageSize, height: Metric.albumDetailImageSize), shadowProminence: .full)
                }
                
                albumDetails
                    .padding(.top, 6)
            }
            .padding(.top, 6)
            .padding(.horizontal)
            
            albumControls
            
            Spacer(minLength: 20)
            
            Divider()
                .padding(.leading)
                .padding(.bottom, 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var albumDetails: some View {
        VStack(spacing: 3) {
            Text(albumDetailObservableObject.media.collectionName)
                .font(.title3.bold())
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            Text(albumDetailObservableObject.media.artistName)
                .font(.title3)
                .foregroundColor(.appAccentColor)
                .lineLimit(1)
            
            Text(albumDetailObservableObject.media.genreAndReleaseYear)
                .font(.caption.bold())
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
    
    var albumControls: some View {
        HStack {
            MainButton(title: "Play", image: Image(systemName: "play.fill")) {
                if !albumDetailObservableObject.waitingForPrepare {
                    albumDetailObservableObject.playAllTracks(isShuffle: false)
                }
            }
            
            Spacer(minLength: 20)
            
            MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
                if !albumDetailObservableObject.waitingForPrepare {
                    albumDetailObservableObject.playAllTracks(isShuffle: true)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 6)
    }
}
