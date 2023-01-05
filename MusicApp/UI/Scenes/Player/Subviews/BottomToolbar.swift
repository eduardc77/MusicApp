//
//  BottomToolbar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer
import AVKit

struct BottomToolbar: View {
  var playerType: PlayerType = .audio
  
  var body: some View {
    HStack(spacing: Metric.buttonsSpacing) {
      Button(action: {}) {
        Image(systemName: "quote.bubble")
          .font(.title2)
          .foregroundColor(playerType == . audio ? .lightGrayColor : .accentColor)
      }
      
      AirplayButton(playerType: playerType)
        .frame(width: 20, height: 20)
      
      Button(action: {}) {
        Image(systemName: "list.bullet")
          .font(.title2)
          .foregroundColor(playerType == . audio ? .lightGrayColor : .accentColor)
      }
    }
    
  }
}


// MARK: - Previews

struct BottomToolBar_Previews: PreviewProvider {
  static var previews: some View {
		VStack {
			Spacer()
			
			BottomToolbar()
				.background(.secondary)
				.padding()
		}
  }
}

extension BottomToolbar {
  enum Metric {
    static let buttonsSpacing: CGFloat = 75
  }
}
