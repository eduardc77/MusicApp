//
//  ContentView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var playerObservableObject = PlayerObservableObject()
  
  var body: some View {
    TabBar()
      .environmentObject(playerObservableObject)
  }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
