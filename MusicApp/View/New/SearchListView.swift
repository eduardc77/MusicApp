//
//  SearchListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        List(searchViewModel.searchResults, id: \.id) { item in
            NavigationLink(destination: MediaDetailView(media: item, imageData: searchViewModel.imagesData[item.artworkUrl100])) {
                SearchListRowItem(
                    media: item,
                    imageData: searchViewModel.imagesData[item.artworkUrl100]
                    
                ).onAppear {
                    if item == searchViewModel.searchResults.last {
                        searchViewModel.loadMore()
                    }
                }
            }
            footer(for: item)
        }
    }
    
    @ViewBuilder
    func footer(for media: Media) -> some View {
        if searchViewModel.isLoadingMore, media == searchViewModel.searchResults.last {
                ProgressView()
                    .padding()
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static let searchViewModel: SearchViewModel = {
        let viewModel = SearchViewModel()
        viewModel.searchResults = Media.sampleData
        return viewModel
    }()
    
    static var previews: some View {
        SearchListView(searchViewModel: searchViewModel)
    }
}
