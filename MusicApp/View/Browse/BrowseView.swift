//
//  BrowseView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct BrowseView: View {
    let title = "Browse"
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                HighlightsView(items: selectedStatiions)

                Text(title)
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VerticalMusicListView(items: radioStations)
            }
            
          
            .navigationTitle(title)
        }
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
