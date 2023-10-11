//
//  ContentView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ContentView: View {
   @StateObject private var playerModel = PlayerModel()
   
   var body: some View {
      TabBar()
         .environmentObject(playerModel)
   }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
