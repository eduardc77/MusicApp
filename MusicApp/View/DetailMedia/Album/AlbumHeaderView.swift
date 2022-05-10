//
//  AlbumHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumHeaderView: View {
    @ObservedObject var albumDetailObservableObject: MediaItemObservableObject
    
    var body: some View {
        VStack {
            VStack {
                MediaImageView(imagePath: albumDetailObservableObject.media.artworkPath.resizedPath(size: 500), size: Size(width: Metric.albumDetailImageSize, height: Metric.albumDetailImageSize), prominentShadow: true)
                    .padding(.bottom, 6)
                
                albumDetails
            }
            .padding(.vertical, 6)
            
            albumControls
            
            Spacer(minLength: 20)
            
            Divider()
                .padding(.leading)
                .padding(.bottom, 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var albumDetails: some View {
        VStack(spacing: 2) {
            Text(albumDetailObservableObject.media.collectionName)
                .font(.title3.bold())
                .foregroundColor(.primary)
            
            Text(albumDetailObservableObject.media.artistName)
                .font(.title3)
                .foregroundColor(.appAccentColor)
            
            Text("\(albumDetailObservableObject.media.genreName.uppercased()) · \(Text(albumDetailObservableObject.media.releaseDate))")
                .font(.caption.bold())
                .foregroundColor(.secondary)
        }
        .lineLimit(1)
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
    }
}
