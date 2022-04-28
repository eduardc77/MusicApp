//
//  TabBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct TabBar: View {
    private var player = MPMusicPlayerController.applicationMusicPlayer
    @State var tabSelection: Int = 0
    @State var expand = false
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection) {
                ListenNowView()
                    .tabItem { Label("Listen Now", systemImage: "play.circle.fill") }
                    .tag(0)
                BrowseView()
                    .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
                    .tag(1)
                RadioView()
                    .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                    .tag(2)
                LibraryView()
                    .tabItem { Label("Library", image: "library") }
                    .tag(3)
                SearchView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
                    .tag(4)
            }
            .accentColor(.appAccentColor)
            
            PlayerView(player: player, expand: $expand, animation: animation)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
