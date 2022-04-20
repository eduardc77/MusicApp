//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var searchTerm = ""
    @State private var isSearchActive: Bool = false
    @State private var selectedIndex = 0
    @State var music = searchMusic
    
    var body: some View {
        NavigationView {
            VStack {
                if searchTerm.isEmpty {
                    CategoryGridView()
                        .navigationTitle("Search")
                } else {
                    
                        Picker("Search In", selection: $selectedIndex) {
                            Text("Apple Music").tag(0)
                            Text("Your Library").tag(1)
                        }
                        .pickerStyle(.segmented)
                        
                        SearchListView(searchViewModel: searchViewModel)
                    
                    
                }
            }
            
        }
        .searchable(text: $searchTerm,
                    placement:.navigationBarDrawer(displayMode:.always),
                    prompt: "Artists, Songs, Lyrics, and More")
    
        .onChange(of: searchTerm) { searchText in
            searchViewModel.search(searchText)
            
        }
        .alert(isPresented: $searchViewModel.showErrorAlert) {
            let message = searchViewModel.errorMessage
            searchViewModel.errorMessage = nil
            
            return Alert(
                title: Text("Error"),
                message: Text(message ?? APIError.generic.localizedDescription)
            )
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
