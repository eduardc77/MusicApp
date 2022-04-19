//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var selectedIndex = 0
    
    @State var music = searchMusic
    
    var body: some View {
        NavigationView {
            CategoryGridView()
                .padding(.bottom)
                .navigationTitle("Search")
            
            // Search Field
                .searchable(text: $searchText,
                            placement:.navigationBarDrawer(displayMode:.always),
                            prompt: "Artists, Songs, Lyrics, and More") {
                    
                    Picker("Search In", selection: $selectedIndex) {
                        Text("Apple Music").tag(0)
                        Text("Your Library").tag(1)
                    }
                    .pickerStyle(.segmented)
                    
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
