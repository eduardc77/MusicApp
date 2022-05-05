//
//  ListenNowView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ListenNowView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                    Divider()
        
                    VStack {
                        HighlightsView(items: selectedStations, imageSize: .large)
                        
                        Text("Best New Songs")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HorizontalMediaGridView(items: musicPlaylists[0], imageSize: .small, rowCount: 4)
                        
                        Text("You Gotta Hear")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HorizontalMediaGridView(items: musicPlaylists[0], imageSize: .medium, rowCount: 1)
                        
                        Text("Stations for You")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VerticalMediaGridView(mediaItems: [Media()], imageSize: .small)
                        
                        Text("New Music")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HorizontalMediaGridView(items: musicPlaylists[0], imageSize: .medium, rowCount: 2)
                    }
                
                    Spacer(minLength: Metric.playerHeight)
            }
            .toolbar(content: {
                AccountNavigationItem()
            })
            .navigationTitle("Listen Now")
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
