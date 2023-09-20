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
      HStack {
         Spacer()
         
         Button {
            switch PlayerObservableObject.playerType {
            case .video:
               PlayerObservableObject.videoPlayer.player.seek(to: CMTime(seconds: Double(PlayerObservableObject.videoPlayer.trackTimePosition - 1), preferredTimescale: 1))
            case .audio:
               PlayerObservableObject.audioPlayer.skipToPreviousItem()
            }
         } label: {
            Image(systemName: "backward.fill")
               .resizable()
               .frame(width: 42, height: 24)
               .foregroundStyle(!playerObservableObject.nowPlayingItem.name.isEmpty ? .white : .lightGrayColor2)
         }
         Spacer()
         
         Button {
            switch PlayerObservableObject.playerType {
            case .video:
               PlayerObservableObject.videoPlayer.toggleIsPlaying()
            case .audio:
               playerObservableObject.playbackState == .playing ? PlayerObservableObject.audioPlayer.pause() : PlayerObservableObject.audioPlayer.play()
            }
            
         } label: {
            switch PlayerObservableObject.playerType {
            case .video:
               (PlayerObservableObject.videoPlayer.player.timeControlStatus == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                  .resizable()
                  .frame(width: 32, height: 36)
                  .foregroundStyle(.white)
            case .audio:
               (playerObservableObject.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                  .resizable()
                  .frame(width: 32, height: 36)
                  .foregroundStyle(.white)
            }
         }
         Spacer()
         
         Button {
            switch PlayerObservableObject.playerType {
            case .video:
               PlayerObservableObject.videoPlayer.player.seek(to: CMTime(seconds: Double(PlayerObservableObject.videoPlayer.trackTimePosition + 5), preferredTimescale: 1))
            case .audio:
               PlayerObservableObject.audioPlayer.skipToNextItem()
               
            }
         } label: {
            Image(systemName: "forward.fill")
               .resizable()
               .frame(width: 42, height: 24)
               .foregroundStyle(!playerObservableObject.nowPlayingItem.name.isEmpty ? .white : .lightGrayColor2)
         }
         Spacer()
      }
      .buttonStyle(.circle(padding: .large))
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
