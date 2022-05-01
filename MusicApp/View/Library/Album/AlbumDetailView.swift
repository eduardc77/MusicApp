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
        VStack {
            AlbumControllView(albumDetailObservableObject: albumDetailObservableObject)
                .background(Color.white)
            
            AlbumSongListView(albumDetailObservableObject: albumDetailObservableObject)
                .padding(.bottom, 80)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AlbumSongListView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        List {
            ForEach(0 ..< albumDetailObservableObject.getSongsCount(), id: \.self) { songIndex in
                HStack {
                    Text("\(songIndex + 1)")
                        .frame(minWidth: 10, idealWidth: 15, maxWidth: 30)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                    Text(albumDetailObservableObject.albumContents?.songs[songIndex].title ?? "")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .font(.subheadline)
                        .foregroundColor(Color.black)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }
                .frame(height: 40)
                .background(Color.white .onTapGesture {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.specificSongPlayButtonPressed(songIndex: songIndex)
                    }
                })
            }
        }
    }
}

struct AlbumControllView: View {
    @ObservedObject fileprivate var albumDetailObservableObject: AlbumDetailObservableObject
    
    var body: some View {
        VStack {
            HStack {
                MediaImageView(image: albumDetailObservableObject.media.artwork, size: Size(width: 100, height: 100))
                    .padding()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(albumDetailObservableObject.media.collectionName ?? "")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .lineLimit(1)
                        .frame(maxWidth: 200, alignment: .leading)
                    Text(albumDetailObservableObject.media.artistName ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                        .frame(alignment: .topLeading)
                        .lineLimit(1)
                        .frame(maxWidth: 200, alignment: .leading)
                    Spacer()
                    
                }
                .padding(.top, 25)
                .padding(.bottom)
                Spacer()
            }
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing)
            
            Divider()
            
            HStack {
                Spacer()
                MainButton(title: "Play", image: Image(systemName: "play.fill")) {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: false)
                    }
                }

                Spacer()
                
                MainButton(title: "Shuffle", image: Image(systemName: "shuffle")) {
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.allSongsPlayButtonPressed(isShuffle: true)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

