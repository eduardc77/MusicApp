//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchObservableObject = SearchObservableObject()
    @State private var searchTerm = ""
    @State private var selectedIndex = 0
    @State private var searchSubmit: Bool = false
    
    var body: some View {
        NavigationView {
            SearchOrCategoryView(searchObservableObject: searchObservableObject, searchSubmit: $searchSubmit)
                .navigationTitle("Search")
            
                .searchable(text: $searchTerm,
                            placement:.navigationBarDrawer(displayMode:.always),
                            prompt: "Artists, Songs, Lyrics, and More",
                            suggestions: {})
                .onSubmit(of: .search) {
                    searchObservableObject.searchTerm = searchTerm
                    searchSubmit = true
                }
            
                .onChange(of: searchTerm) { term in
                    searchObservableObject.searchTerm = term
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    searchSubmit = false
                }
        }
    }
}

struct SearchOrCategoryView: View {
    @Environment(\.isSearching) private var isSearching
    @ObservedObject var searchObservableObject: SearchObservableObject
    @Binding var searchSubmit: Bool
    
    var body: some View {
        if !isSearching {
            CategoryGridView()
        } else {
            searchResults
        }
    }
}

// MARK: - Search Results View

extension SearchOrCategoryView {
    var searchResults: some View {
        ZStack {
            SearchListView(searchObservableObject: searchObservableObject, searchSubmit: $searchSubmit)
            
            if searchObservableObject.searchLoadedWithNoResults {
                VStack {
                    Text("No Results")
                        .font(.title2).bold()
                        .foregroundColor(.primary)
                    Text("Try a new search.")
                        .foregroundColor(.secondary)
                        .font(.body)
                }
                .padding(.bottom)
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
