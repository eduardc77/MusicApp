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
        Group {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(searchViewModel.searchResults) { item in
                        Section(footer: footer(for: item)) {
                            SearchListRowItem(
                                media: item,
                                imageData: searchViewModel.imagesData[item.imageUrl] ?? Data()
                            )

                            Divider()
                                .onAppear {
                                    if item == searchViewModel.searchResults.last {
                                        searchViewModel.loadMore()
                                    }
                                }
                        }
                    }
                }
                .padding([.all], 16)
            }
        }
    }

    @ViewBuilder
    func footer(for media: Media) -> some View {
        if searchViewModel.isLoadingMore, media == searchViewModel.searchResults.last {
            HStack {
                Spacer()

                ProgressView("Loading...")
                    .padding([.top, .bottom], 10)

                Spacer()
            }
        }  else {
            EmptyView()
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
