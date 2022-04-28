//
//  ListenNowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ListenNowView: View {
    @State private var navigationTitle = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AppNavigationBar()
                    
                    VStack {
                        HighlightsView(items: selectedStations, imageSize: .large)
                        
                        Text("Best New Songs")
                            .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        HorizontalMusicListView(items: musicPlaylists[0], imageSize: .small, rowCount: 4)
                        
                        Text("You Gotta Hear")
                            .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        HorizontalMusicListView(items: musicPlaylists[0], imageSize: .medium, rowCount: 1)
                        
                        Text("Stations for You")
                            .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        VerticalMusicListView(items: musicPlaylists[1], imageSize: .small)
                        
                        Text("New Releases")
                            .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        HorizontalMusicListView(items: musicPlaylists[0], imageSize: .medium, rowCount: 2)
                    }
                    Spacer(minLength: Metric.playerHeight)
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self,
                                           value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { scrollOffset in
                    navigationTitle = scrollOffset > 48 ? "Listen Now" : ""
                }
                .animation(.spring(), value: navigationTitle)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(navigationTitle)
            .coordinateSpace(name: "scroll")
        }
    }
    
    struct ScrollViewOffsetPreferenceKey: PreferenceKey {
        typealias Value = CGFloat
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value += nextValue()
        }
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
