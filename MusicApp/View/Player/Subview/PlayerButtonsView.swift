//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerButtonsView: View {
    @StateObject var playerObservableObject: PlayerObservableObject

    var body: some View {
        HStack() {
            Spacer()
            Button(action: {}) {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }.padding(.horizontal, 40)
            Spacer()
           
            Button(action: {
                guard playerObservableObject.nowPlayingItem != nil else { return }
                playerObservableObject.playbackState == .playing ? playerObservableObject.player.pause() : playerObservableObject.player.play()
            },
                   label: {
                (playerObservableObject.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                    .font(.system(size: 48))
                   .foregroundColor(.primary)
                   
            })
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }.padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top)
    }
}
