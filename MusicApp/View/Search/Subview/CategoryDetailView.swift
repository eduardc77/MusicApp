//
//  CategoryDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct CategoryDetailView: View {
    @EnvironmentObject private var playerObservableObject: PlayerObservableObject
    var category: SearchCategoryModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack() {
                Text(category.title)
                    .font(.largeTitle).bold()
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HighlightsView(items: selectedMusic[category.tag], imageSize: .highlight)
                
                HorizontalMediaGridView(mediaItems: musicPlaylists, title: "Best \(category.title) Music", imageSize: .albumCarouselItem, rowCount: 2)
                    .navigationBarTitleDisplayMode(.inline)
            }
            
            if playerObservableObject.showPlayerView {
                Spacer(minLength: Metric.playerHeight)
            }
        }
        
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: searchCategories[0])
    }
}

