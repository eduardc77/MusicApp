//
//  TabBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct TabBar: View {
    @State var expand = false
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                ListenNowView().tabItem { Label("Listen Now", systemImage: "play.circle.fill") }
                BrowseView().tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
                RadioView().tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                LibraryView().tabItem { Label("Library", systemImage: "square.stack.fill") }
                SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
            }
            .accentColor(.red)

            PlayerView(expand: $expand, animation: animation)
               
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
