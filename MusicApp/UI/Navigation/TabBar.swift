//
//  TabBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

enum Tab {
   case listenNow
   case browse
   case radio
   case library
   case search
}

struct TabBar: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @State var selection: Tab = .listenNow
   
   var body: some View {
      ZStack(alignment: .bottom) {
         TabView(selection: $selection) {
            ListenNowView()
               .tabItem { Label("Listen Now", systemImage: "play.circle.fill") }
               .tag(Tab.listenNow)
               .toolbar(playerModel.expand ? .hidden : .automatic, for: .tabBar)
            BrowseView()
               .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill").font(.largeTitle) }
               .tag(Tab.browse)
            RadioView()
               .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
               .tag(Tab.radio)
            LibraryView(tabSelection: $selection)
               .tabItem { Label("Library", image: "music.stack.fill") }
               .tag(Tab.library)
            SearchView()
               .tabItem { Label("Search", systemImage: "magnifyingglass") }
               .tag(Tab.search)
         }
         
         PlayerView()
            .opacity(playerModel.showPlayerView ? 1 : 0)
            .animation(.default, value: playerModel.hasRecentMedia)
      }
      .ignoresSafeArea(.keyboard)
   }
}


// MARK: - Previews

struct TabBar_Previews: PreviewProvider {
   static var previews: some View {
      TabBar()
         .environmentObject(PlayerModel())
   }
}

