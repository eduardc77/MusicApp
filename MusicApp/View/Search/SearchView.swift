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
    
    var body: some View {
        NavigationView {
            VStack {
                if searchTerm.isEmpty {
                    CategoryGridView()
                } else {
                    
//                    ZStack {
//
//                    Picker("Search In", selection: $selectedIndex) {
//                        Text("Apple Music").tag(0)
//                        Text("Your Library").tag(1)
//                    }
//                    .navigationBarTitleDisplayMode(.inline)
//                    .pickerStyle(.segmented)
//                    .padding(.horizontal)
//                    }
                    ZStack {
                        if searchObservableObject.noResultsFound {
                            VStack {
                                Text("No Results")
                                    .font(.title2).bold()
                                    .foregroundColor(.primary)
                                Text("Try a new search.")
                                    .foregroundColor(.secondary)
                                    .font(.body)
                            }
                            .padding(.bottom)
                        } else {
                            
                            SearchListView(searchObservableObject: searchObservableObject)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            
            .alert(isPresented: $searchObservableObject.showErrorAlert) {
                let message = searchObservableObject.errorMessage
                searchObservableObject.errorMessage = nil
                
                return Alert(
                    title: Text("Error"),
                    message: Text(message ?? APIError.generic.localizedDescription)
                )
            }
        }
        .searchable(text: $searchTerm,
                    placement:.navigationBarDrawer(displayMode:.always),
                    prompt: "Artists, Songs, Lyrics, and More") {
            //            ForEach(searchViewModel.searchResults) { suggestion in
            //                Text(suggestion.trackName)
            //            }.searchCompletion(searchTerm)
        }
                    .onSubmit(of: .search) {
                        searchObservableObject.searchTerm = searchTerm
                        searchObservableObject.search()
                    }
                    .onChange(of: searchTerm) { term in
                        searchObservableObject.searchTerm = term
                        searchObservableObject.search()
                    }
                    
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
