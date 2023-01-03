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
  
  var body: some View {
    NavigationView {
      SearchOrCategoryView(searchObservableObject: searchObservableObject)
        .navigationTitle("Search")
      
        .searchable(text: $searchTerm,
                    placement:.navigationBarDrawer(displayMode:.always),
                    prompt: searchObservableObject.searchPrompt.message,
                    suggestions: {})
        .onSubmit(of: .search) {
          searchObservableObject.searchTerm = searchTerm
          searchObservableObject.searchSubmit = true
        }
      
        .onChange(of: searchTerm) { term in
          searchObservableObject.searchTerm = term
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
          searchObservableObject.searchSubmit = false
        }
    }
  }
}

struct SearchOrCategoryView: View {
  @Environment(\.isSearching) private var isSearching
  @ObservedObject var searchObservableObject: SearchObservableObject
  
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
      SearchListView(searchObservableObject: searchObservableObject)
      
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
				.environmentObject(PlayerObservableObject())
		}
}
