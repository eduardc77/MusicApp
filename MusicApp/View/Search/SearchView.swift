//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchObservableObject()
    @State private var searchTerm = ""
    @State private var isSearchActive: Bool = false
    @State private var selectedIndex = 0
    @State var music = searchMusic
    
    var body: some View {
        NavigationView {
            VStack {
                if searchTerm.isEmpty {
                    CategoryGridView()
                        .animation(.default, value: searchTerm)
                } else {
                    VStack {
                        Picker("Search In", selection: $selectedIndex) {
                            Text("Apple Music").tag(0)
                            Text("Your Library").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .background(.ultraThinMaterial)
                        
                        ZStack {
                            SearchListView(searchViewModel: searchViewModel)

                            
                            if searchViewModel.noResultsFound {
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
                    }.padding()
                }
            }
            .navigationTitle("Search")
            
            .alert(isPresented: $searchViewModel.showErrorAlert) {
                let message = searchViewModel.errorMessage
                searchViewModel.errorMessage = nil
                
                return Alert(
                    title: Text("Error"),
                    message: Text(message ?? APIError.generic.localizedDescription)
                )
            }
        }
        .searchable(text: $searchTerm,
                    placement:.navigationBarDrawer(displayMode:.always),
                    prompt: "Artists, Songs, Lyrics, and More")
        
        .onChange(of: searchTerm) { term in
            searchViewModel.searchTerm = term
            searchViewModel.search()
            
        }
        //        .onSubmit {
        //            searchViewModel.searchTerm = searchTerm
        //            searchViewModel.search()
        //        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
