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
                AlbumCoverView(albumDetailObservableObject: albumDetailObservableObject)
                
                AlbumSongListView(albumDetailObservableObject: albumDetailObservableObject)
                
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
                        .foregroundStyle(Color.accentColor, Color.secondary.opacity(0.16))
                }
                
                Button{ } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(Color.accentColor, Color.secondary.opacity(0.16))
                }
            }
        }
    }
}

struct AlbumCoverView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        VStack {
            VStack {
                MediaImageView(image: albumDetailObservableObject.media.artwork, size: Size(width: 230, height: 230), isLargeArtworkSize: true)
                    .padding(.bottom, 6)
                
                albumDetails
            }
            .padding(.top, 6)
            .padding(.bottom, 6)
            
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
                .foregroundColor(.accentColor)
            
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
                    albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: false)
                }
            }
            
            Spacer(minLength: 20)
            
            MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
                if !albumDetailObservableObject.waitingForPrepare {
                    albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: true)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct AlbumSongListView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< albumDetailObservableObject.getSongsCount(), id: \.self) { songIndex in
                HStack {
                    VStack {
                        Spacer()
                        
                        Text("\(songIndex + 1)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .padding(.trailing, 6)
                        
                        Spacer(minLength: 16)
                    }
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(albumDetailObservableObject.albumContents?.songs[songIndex].title ?? "")
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .padding(.trailing)
                        }
                        
                        Spacer(minLength: 16)
                        
                        Divider()
                    }
                }
                .frame(minHeight: 12, maxHeight: .infinity)
                .padding(.leading, 24)
                
                .onTapGesture {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.specificSongPlayButtonPressed(songIndex: songIndex)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let releaseDate = albumDetailObservableObject.media.releaseDate {
                    Text("\(releaseDate.addingTimeInterval(-86400), style: .date)")
                }
                
                Text("\(albumDetailObservableObject.albumTrackCount) songs, \(albumDetailObservableObject.albumDuration) minutes")
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }
}

