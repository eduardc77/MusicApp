//
//  SearchListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject var searchViewModel: SearchObservableObject
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Divider()
                ForEach(searchViewModel.searchResults, id: \.id) { item in
                    NavigationLink {
                        MediaDetailView(media: item, imageData: searchViewModel.imagesData[item.artworkUrl100])
                    } label: {
                        SearchListRowItem(
                            media: item,
                            imageData: searchViewModel.imagesData[item.artworkUrl100]
                        )
                        .onAppear {
                            guard item == searchViewModel.searchResults[searchViewModel.searchResults.count - 1] else { return }
                            searchViewModel.loadMore()
                        }
                    }
                    Divider()
                }
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static let searchViewModel: SearchObservableObject = {
        let viewModel = SearchObservableObject()
        viewModel.searchResults = Media.sampleData
        return viewModel
    }()
    
    static var previews: some View {
        SearchListView(searchViewModel: searchViewModel)
    }
}
