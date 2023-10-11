//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import AVKit

struct PlayerControls: View {
   @EnvironmentObject var playerModel: PlayerModel
   
   var body: some View {
      HStack {
         Spacer()
         
         Button {
            switch PlayerModel.playerType {
            case .video:
               PlayerModel.videoPlayer.player.seek(to: CMTime(seconds: Double(PlayerModel.videoPlayer.trackTimePosition - 1), preferredTimescale: 1))
            case .audio:
               PlayerModel.audioPlayer.skipToPreviousItem()
            }
         } label: {
            Image(systemName: "backward.fill")
               .resizable()
               .frame(width: 42, height: 24)
               .foregroundStyle(!playerModel.nowPlayingItem.name.isEmpty ? .white : .lightGrayColor2)
         }
         Spacer()
         
         Button {
            switch PlayerModel.playerType {
            case .video:
               PlayerModel.videoPlayer.toggleIsPlaying()
            case .audio:
                  playerModel.playbackState == .playing ? PlayerModel.audioPlayer.pause() : PlayerModel.audioPlayer.play()
            }
            
         } label: {
            switch PlayerModel.playerType {
            case .video:
               (PlayerModel.videoPlayer.player.timeControlStatus == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                  .resizable()
                  .frame(width: 32, height: 36)
                  .foregroundStyle(.white)
            case .audio:
               (playerModel.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                  .resizable()
                  .frame(width: 32, height: 36)
                  .foregroundStyle(.white)
            }
         }
         Spacer()
         
         Button {
            switch PlayerModel.playerType {
            case .video:
               PlayerModel.videoPlayer.player.seek(to: CMTime(seconds: Double(PlayerModel.videoPlayer.trackTimePosition + 5), preferredTimescale: 1))
            case .audio:
               PlayerModel.audioPlayer.skipToNextItem()
               
            }
         } label: {
            Image(systemName: "forward.fill")
               .resizable()
               .frame(width: 42, height: 24)
               .foregroundStyle(!playerModel.nowPlayingItem.name.isEmpty ? .white : .lightGrayColor2)
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
         .environmentObject(PlayerModel())
         .background(.secondary)
   }
}
