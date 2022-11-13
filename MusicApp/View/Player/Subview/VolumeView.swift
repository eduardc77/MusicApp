//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VolumeView: View {
  var playerType: PlayerType = .audio
  
  var body: some View {
    VStack {
      HStack {
        Image(systemName: "speaker.fill")
          .foregroundColor(.lightGrayColor)
          .padding(.trailing, 6)
        
        VolumeSlider()
          .accentColor(.lightGrayColor)
          .controlSize(.regular)
          .frame(width: UIScreen.main.bounds.width / 1.5, height: 18)
        
        Image(systemName: "speaker.wave.2.fill")
          .foregroundColor(.lightGrayColor)
          .padding(.leading, 6)
      }
      .padding(.vertical)
      
      Spacer()
      BottomToolbar(playerType: playerType)
    }
  }
}


// MARK: - Previews

struct VolumeView_Previews: PreviewProvider {
  static var previews: some View {
		VStack {
			Spacer()

			VolumeView()
				.background(.secondary)
				.frame(height: 100)
				.padding()
		}
  }
}
