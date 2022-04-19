//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VolumeView: View {
    @State var volume: CGFloat = 0
    
    var body: some View {
        HStack() {
            Image(systemName: "speaker.fill")
                .foregroundColor(.secondary)
                .padding(.leading)
            
            Slider(value: $volume,  in: 1...10).accentColor(.secondary)

            Image(systemName: "speaker.wave.2.fill")
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
        
        BottomToolbar().padding(.bottom, 30)
    }
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}

extension VolumeView {
    enum Metric {
        static let regularSpacing: CGFloat = 16
        static let buttonsSpacing: CGFloat = 70
    }
}
