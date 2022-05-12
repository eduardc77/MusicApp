//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerButtonsView: View {
    @ObservedObject var playerObservableObject: PlayerObservableObject
    
    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                guard playerObservableObject.nowPlayingItem != nil else { return }
                print("Backward Button Tapped")
                
            }) {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .foregroundColor(playerObservableObject.nowPlayingItem != nil ? .white : .lightGrayColor2)
            }.padding(.horizontal, 40)
            Spacer()
            
            Button(action: {
                guard playerObservableObject.nowPlayingItem != nil else { return }
                playerObservableObject.playbackState == .playing ? playerObservableObject.player.pause() : playerObservableObject.player.play()
            },
                   label: {
                (playerObservableObject.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill"))
                    .resizable()
                    .frame(width: 36, height: 40)
                    .foregroundColor(.white)
                
            })
            Spacer()
            
            Button(action: {
                guard playerObservableObject.nowPlayingItem != nil else { return }               
                print("Forward Button Tapped")
                
            }) {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(playerObservableObject.nowPlayingItem != nil ? .white : .lightGrayColor2)
            }.padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.vertical)
    }
}
