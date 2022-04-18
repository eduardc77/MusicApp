//
//  TabBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct TabBar: View {
    @State var selection = 0
    @State var expand = false
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ListenNowView().tabItem { Label("Listen Now", systemImage: "play.circle.fill").padding() }
                BrowseView().tabItem { Label("Browse", systemImage: "square.grid.2x2.fill").padding() }
                RadioView().tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right").padding() }
                LibraryView().tabItem { Label("Library", systemImage: "square.stack.fill").padding() }
                SearchView().tabItem { Label("Search", systemImage: "magnifyingglass").padding() }
            }
            .accentColor(.red)

            PlayerView(animation: animation, expand: $expand)
            
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
