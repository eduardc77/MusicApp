//
//  PlayerButtonsView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerButtonsView: View {
    @Binding var isPlaying: Bool
    var animation: Namespace.ID
    
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
                Image(systemName: "play.fill")
                    .matchedGeometryEffect(id: "Play", in: animation, properties: .position)
                    .font(.system(size: 48))
                    .foregroundColor(.primary)
                :
                Image(systemName: "pause.fill")
                    .matchedGeometryEffect(id: "Pause", in: animation, properties: .position)
                    .font(.system(size: 48))
                    .foregroundColor(.primary)
            })
        
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "forward.fill")
                    .matchedGeometryEffect(id: "Forward", in: animation, properties: .position)
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }.padding()
            
            Spacer()
        }
    }
}
