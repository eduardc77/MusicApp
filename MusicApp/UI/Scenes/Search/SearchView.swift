//
//  SearchView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SearchView: View {
   @StateObject private var searchModel = SearchViewModel()
   @State private var searchTerm = ""
   @State private var keyboardDidHide: Bool = false
   
   var body: some View {
      NavigationStack {
         SearchOrCategoryView(searchModel: searchModel)
            .navigationTitle("Search")
         
            .searchable(text: $searchTerm,
                        placement:.navigationBarDrawer(displayMode:.always),
                        prompt: searchModel.searchPrompt.message,
                        suggestions: {})
         
            .onSubmit(of: .search) {
               DispatchQueue.main.async {
                  searchModel.searchSubmit = true
               }
            }
         
            .onChange(of: searchTerm) { _, term in
               searchModel.resetChachedContent()
               keyboardDidHide = false
               searchModel.searchTerm = term
               searchModel.searchSubmit = false
               searchModel.selectedMediaType = .topResult
            }
      }
   }
}

struct SearchOrCategoryView: View {
   @Environment(\.isSearching) private var isSearching
   @ObservedObject var searchModel: SearchViewModel
   
   var body: some View {
      if !isSearching {
         ScrollView {
            CategoryGridView()
         }
      } else {
         searchResults
      }
   }
}

// MARK: - Search Results View

extension SearchOrCategoryView {
   var searchResults: some View {
      ZStack {
         SearchListView(searchModel: searchModel)
         
         if searchModel.searchLoadedWithNoResults {
            VStack {
               Text("No Results")
                  .font(.title2).bold()
                  .foregroundStyle(Color.primary)
               Text("Try a new search.")
                  .foregroundStyle(Color.secondary)
                  .font(.body)
            }
            .padding(.bottom)
         }
      }
   }
}

enum SearchPrompt: Int {
   case appleMusic
   case library
   
   var message: String {
      switch self {
      case .appleMusic: return "Artists, Songs, Lyrics and More"
      case .library: return "Your Library"
      }
   }
}


// MARK: - Previews

struct SearchView_Previews: PreviewProvider {
   static var previews: some View {
      SearchView()
         .environmentObject(PlayerModel())
   }
}
