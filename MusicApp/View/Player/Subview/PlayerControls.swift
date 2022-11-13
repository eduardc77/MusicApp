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
          playerObservableObject.videoPlayer.player.seek(to: CMTime(seconds: Double(playerObservableObject.videoPlayer.trackTimePosition - 1), preferredTimescale: 1))
        case .audio:
          if playerObservableObject.audioPlayer.currentPlaybackTime > 6 {
            playerObservableObject.audioPlayer.skipToBeginning()
          } else {
            playerObservableObject.audioPlayer.skipToPreviousItem()
          }
        }
      } label: {
        Image(systemName: "backward.fill")
          .font(.largeTitle)
          .foregroundColor(!playerObservableObject.nowPlayingItem.media.name.isEmpty ? .white : .lightGrayColor2)
      }
      
      Spacer()
      
      Button {
        switch playerObservableObject.playerType {
        case .video:
          playerObservableObject.videoPlayer.toggleIsPlaying()
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
          playerObservableObject.audioPlayer.skipToNextItem()
        }
      } label: {
        Image(systemName: "forward.fill")
          .font(.largeTitle)
          .foregroundColor(!playerObservableObject.nowPlayingItem.media.name.isEmpty ? .white : .lightGrayColor2)
      }
      
      Spacer()
    }
    .padding(.vertical)
  }
}


// MARK: - Previews

struct PlayerControls_Previews: PreviewProvider {
	static var previews: some View {
		PlayerControls()
			.environmentObject(PlayerObservableObject())
			.background(.secondary)
	}
}
