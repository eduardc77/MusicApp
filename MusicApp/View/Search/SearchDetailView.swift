//
//  SearchDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchDetailView: View {
    
    var category: SearchCategoryModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack() {
                Text(category.title)
                    .font(.largeTitle).bold()
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HighlightsView(items: selectedMusic[category.tag])
                
                HStack {
                    Text("Placeholder")
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("Placeholder") {}
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
                
                HorizontalMusicListView(items: musicPlaylists[category.tag])
                
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .padding(.bottom, Metric.playerHeight)
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView(category: SearchCategoryModel.example)
    }
}

