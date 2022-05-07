//
//  AlbumHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumHeaderView: View {
    @ObservedObject var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        VStack {
            VStack {
                MediaImageView(image: albumDetailObservableObject.media.artwork, size: Size(width: 230, height: 230), isLargeArtworkSize: true)
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
            Text(albumDetailObservableObject.media.collectionName ?? "")
                .font(.title3.bold())
                .foregroundColor(.primary)
            
            Text(albumDetailObservableObject.media.artistName ?? "")
                .font(.title3)
                .foregroundColor(.appAccentColor)
            
            Text(albumDetailObservableObject.media.releaseDate != nil ? "\(albumDetailObservableObject.media.primaryGenreName?.uppercased() ?? "") · \(Text(albumDetailObservableObject.media.releaseDate ?? Date(), format: .dateTime.year()))" : "\(albumDetailObservableObject.media.primaryGenreName?.uppercased() ?? "")")
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
