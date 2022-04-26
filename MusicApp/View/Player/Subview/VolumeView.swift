//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VolumeView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.lightGrayColor)
                    .padding(.leading)
                
                VolumeSlider()
                    .accentColor(.lightGrayColor)
                    .controlSize(.mini)
                    .frame(width: UIScreen.main.bounds.width / 1.4, height: 18)
                
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(.lightGrayColor)
                    .padding(.trailing)
            }
            .padding(.vertical)
            
            Spacer()
            BottomToolbar()
        }
    }
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}
