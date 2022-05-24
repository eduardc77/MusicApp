//
//  AlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import SwiftUI
import MediaPlayer

struct AlbumTrackList: View {
    @StateObject var mediaItemObservableObject = MediaItemObservableObject()
    @State private var playing: (Int, Bool) = (0, false)
    @State private var playingStarted: Bool = false
    
    private let player = MPMusicPlayerController.applicationMusicPlayer
    let media: Media
    
    var body: some View {
        Group {
            if mediaItemObservableObject.loadingTracks {
                LoadingView()
            } else {
                VStack(alignment: .leading) {
                    ForEach(Array(zip(mediaItemObservableObject.tracks.indices, mediaItemObservableObject.tracks)), id: \.0) { trackIndex, track in
                        HStack {
                            VStack {
                                HStack {
                                    Group {
                                        if playing.0 == trackIndex, playingStarted {
                                            NowPlayingEqualizerBars(animating: $playing.1)
                                                .frame(width: 16, height: 8)
                                        } else {
                                            Text(track.trackNumber)
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                    }
                                    .frame(width: 20, height: 8)
                                    
                                    MediaItemName(name: track.trackName, explicitness: track.trackExplicitness)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "ellipsis")
                                        .padding(.trailing)
                                }
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.white.opacity(0.001))
                                
                                Divider()
                                    .padding(.leading, 24)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.leading)
                        
                        .onTapGesture {
                            playing.0 = trackIndex
                            playing.1.toggle()
                            
                            playingStarted = true
                            
                            mediaItemObservableObject.playTrack(withId: track.id)
                        }
                        
                        .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
                            if player.playbackState == .playing {
                                playing.1 = true
                            } else if player.playbackState == .paused {
                                playing.1 = false
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        if let releaseDate = media.releaseDate {
                            Text("\(releaseDate)")
                        }
                        
                        Text("\(media.trackCount) songs, \(media.duration) minutes")
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
                
            }
            
        }
        .onAppear {
            mediaItemObservableObject.fetchTracks(for: media.id)
            mediaItemObservableObject.configureAlbumDetails()
        }
    }
}
