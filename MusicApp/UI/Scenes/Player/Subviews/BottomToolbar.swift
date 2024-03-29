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
      HStack {
         Button(action: {}) {
            Image(systemName: "quote.bubble")
               .font(.title2)
               .foregroundStyle(playerType == . audio ? .lightGrayColor : Color.accentColor)
         }
         Spacer()
         
         AirplayButton(playerType: playerType)
            .frame(width: 22, height: 22)
         
         Spacer()
         
         Button(action: {}) {
            Image(systemName: "list.bullet")
               .font(.title2)
               .foregroundStyle(playerType == . audio ? .lightGrayColor : Color.accentColor)
         }
      }
      .padding(.horizontal, 48)
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
