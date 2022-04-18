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
            Button(action: {
                    isPlaying.toggle()
            },
                    label: {
                isPlaying ?
                Image(systemName: "play.fill")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .matchedGeometryEffect(id: "Play", in: animation, properties: .position, anchor: .trailing)
                :
                Image(systemName: "pause.fill")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .matchedGeometryEffect(id: "Pause", in: animation, properties: .position, anchor: .trailing)
                }
            )
            Spacer()
            Button(action: {}) {
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                    .matchedGeometryEffect(id: "Forward", in: animation, properties: .position, anchor: .trailing)
            }.padding()
            Spacer()
        }.animation(.linear(duration: 0.16), value: animation)
    }
}
