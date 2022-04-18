//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
    @State var categories = searchCategories
    @StateObject private var searchViewModel = SearchViewModel()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    @State private var searchText = ""
    @State private var isEditing = false
    @State private var selectedIndex = 0
    
    @State var music = searchMusic
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        Text("Browse Categories")
                            .font(.title2).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: columns) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination:
                                            SearchDetailView(category: category)
                                            .navigationTitle("")
                                            .navigationBarTitleDisplayMode(.inline)
                            ) {
                                Image(category.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 2.3,
                                           alignment: .leading)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, Metric.playerHeight)
            .navigationBarTitle("Search")
        }
    }
    // Search field
        .searchable(text: $searchText,
                prompt: "Artists, Songs, Lyrics, and More") {
            
            Picker("Search in", selection: $selectedIndex) {
                Text("Apple Music").tag(0)
                Text("Your Library").tag(1)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            
        ZStack {
            SearchListView(searchViewModel: searchViewModel)

            if searchViewModel.isFetchingInitialResults {
                ProgressView()
            }

            if searchViewModel.noResultsFound {
                Text("No results found.")
                    .bold()
            }
        }
        
            .onChange(of: searchText) { searchText in
                searchViewModel.search(searchText)
            }
        }.alert(isPresented: $searchViewModel.showErrorAlert) {
            let message = searchViewModel.errorMessage
            searchViewModel.errorMessage = nil

            return Alert(
                title: Text("Error"),
                message: Text(message ?? APIError.generic.localizedDescription)
            )
        }
    }
}

extension SearchView {
    enum Metric {
        static let playerHeight: CGFloat = 80
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
