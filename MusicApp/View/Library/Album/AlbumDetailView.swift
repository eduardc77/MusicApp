//
//  AlbumDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
    @StateObject private var albumDetailObservableObject: AlbumDetailObservableObject
    
    init(media: Media) {
        _albumDetailObservableObject = StateObject(wrappedValue: AlbumDetailObservableObject(media: media))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AlbumControllView(albumDetailObservableObject: albumDetailObservableObject)
                
                AlbumSongListView(albumDetailObservableObject: albumDetailObservableObject)
                
                Spacer(minLength: Metric.playerHeight)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlbumSongListView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        List {
            ForEach(0 ..< albumDetailObservableObject.getSongsCount(), id: \.self) { songIndex in
                HStack {
                    Text("\(songIndex + 1)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Text(albumDetailObservableObject.albumContents?.songs[songIndex].title ?? "")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }
                
                .onTapGesture {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.specificSongPlayButtonPressed(songIndex: songIndex)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct AlbumControllView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        
        VStack {
            VStack {
                MediaImageView(image: albumDetailObservableObject.media.artwork, size: Size(width: 230, height: 230))
                    .padding(.bottom, 4)
                    
                
                VStack(spacing: 1) {
                    Text(albumDetailObservableObject.media.collectionName ?? "")
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(albumDetailObservableObject.media.artistName ?? "")
                        .font(.title3)
                        .foregroundColor(.accentColor)
                        .lineLimit(1)
                    
                    Text(albumDetailObservableObject.media.releaseDate != nil ? "\(albumDetailObservableObject.media.primaryGenreName?.uppercased() ?? "") · \(Text(albumDetailObservableObject.media.releaseDate ?? Date(), format: .dateTime.year()))" : "\(albumDetailObservableObject.media.primaryGenreName?.uppercased() ?? "")")
                    
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(.top, 4)
            .padding(.bottom, 4)
 
            HStack {
                Spacer()
                MainButton(title: "Play", image: Image(systemName: "play.fill")) {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: false)
                    }
                }
                
                Spacer(minLength: 20)
                
                MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: true)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
           
        }
        .frame(height: Metric.albumDetailHeaderHeight)
    }
}

