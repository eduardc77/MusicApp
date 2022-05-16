//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import AVKit

struct PlayerControls: View {
    @EnvironmentObject var playerObservableObject: PlayerObservableObject
    
    var body: some View {
        HStack() {
            Spacer()
            
            Button {
                switch playerObservableObject.playerType {
                case .video:
                    playerObservableObject.videoPlayer.player.seek(to: CMTime(seconds: Double(playerObservableObject.videoPlayer.trackTimePosition - 5), preferredTimescale: 1))
                case .audio:
                    guard playerObservableObject.nowPlayingItem != nil else { return }
                    print("Backward Button Tapped")
                }
            } label: {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .foregroundColor(playerObservableObject.nowPlayingItem != nil ? .white : .lightGrayColor2)
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                switch playerObservableObject.playerType {
                case .video:
                    if playerObservableObject.videoPlayer.isPlaying {
                        playerObservableObject.videoPlayer.isPlaying = false
                    }
                    else {
                        playerObservableObject.videoPlayer.isPlaying = true
                    }
                case .audio:
                    playerObservableObject.playbackState == .playing ? playerObservableObject.audioPlayer.pause() : playerObservableObject.audioPlayer.play()
                }
                
            } label: {
                switch playerObservableObject.playerType {
                case .video:
                    (playerObservableObject.videoPlayer.isPlaying ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                        .resizable()
                        .frame(width: 36, height: 40)
                        .foregroundColor(.white)
                case .audio:
                    (playerObservableObject.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                        .resizable()
                        .frame(width: 36, height: 40)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Button {
                switch playerObservableObject.playerType {
                case .video:
                    playerObservableObject.videoPlayer.player.seek(to: CMTime(seconds: Double(playerObservableObject.videoPlayer.trackTimePosition + 5), preferredTimescale: 1))
                case .audio:
                    guard playerObservableObject.nowPlayingItem != nil else { return }
                    print("Forward Button Tapped")
                }
            } label: {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(playerObservableObject.nowPlayingItem != nil ? .white : .lightGrayColor2)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.vertical)
    }
}
