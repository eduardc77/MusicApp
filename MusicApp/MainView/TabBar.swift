//
//  TabBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct TabBar: View {
    @State var selection: Tab = .listenNow
    @State var expand = false
    @Namespace var animation
    
    enum Tab {
        case listenNow
        case browse
        case radio
        case library
        case search
    }
    
    private var player = MPMusicPlayerController.applicationMusicPlayer
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ListenNowView()
                    .tabItem { Label("Listen Now", systemImage: "play.circle.fill") }
                    .tag(Tab.listenNow)
                BrowseView()
                    .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
                    .tag(Tab.browse)
                RadioView()
                    .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                    .tag(Tab.radio)
                LibraryView()
                    .tabItem { Label("Library", image: "library") }
                    .tag(Tab.library)
                SearchView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
                    .tag(Tab.search)
            }
            .accentColor(.appAccentColor)
            
            PlayerView(player: player, expand: $expand, animation: animation)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
