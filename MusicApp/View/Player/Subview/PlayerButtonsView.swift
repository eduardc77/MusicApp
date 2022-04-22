//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerButtonsView: View {
    @Binding var isPlaying: Bool

    var body: some View {
        HStack() {
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }.padding()
            
            Spacer()
            
            Button(action: { isPlaying.toggle() },
                   label: {
                isPlaying ?
                Image(systemName: "pause.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.primary)
                :
                Image(systemName: "play.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.primary)
            })
        
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }.padding()
            
            Spacer()
        }
    }
}
