//
//  AlbumTrackList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct AlbumTrackList: View {
    @StateObject var albumDetailObservableObject: MediaItemObservableObject
    @State private var playing: (Int, Bool) = (0, false)
    @State private var playingStarted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< albumDetailObservableObject.trackCount, id: \.self) { trackIndex in
                HStack {
                    VStack {
                        HStack {
                            Group {
                                if playing.0 == trackIndex, playingStarted {
                                    NowPlayingEqualizerBars(animating: $playing.1)
                                        .frame(width: 16, height: 8)
                                } else {
                                    Text(String(albumDetailObservableObject.trackNumber(at: trackIndex)))
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            .frame(width: 20, height: 8)
                            
                            Text(albumDetailObservableObject.trackTitle(at: trackIndex))
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
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
                    if !albumDetailObservableObject.waitingForPrepare {
                        albumDetailObservableObject.playTrack(at: trackIndex)
                        playing.0 = trackIndex
                        playing.1.toggle()
                        
                        playingStarted = true
                    }
                }
                
                .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)){ _ in
                    if albumDetailObservableObject.player.playbackState == .playing {
                        playing.1 = true
                    } else if albumDetailObservableObject.player.playbackState == .paused {
                        playing.1 = false
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let releaseDate = albumDetailObservableObject.media.releaseDate {
                    Text("\(releaseDate)")
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
