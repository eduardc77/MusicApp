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
		NavigationStack {
			SearchOrCategoryView(searchObservableObject: searchObservableObject)
				.navigationTitle("Search")

				.searchable(text: $searchTerm,
								placement:.navigationBarDrawer(displayMode:.always),
								prompt: searchObservableObject.searchScope.prompt,
								suggestions: {})

				.searchScopes($searchObservableObject.searchScope) {
					if !searchObservableObject.searchSubmit {
						Text(SearchScope.appleMusic.rawValue).tag(SearchScope.appleMusic)
						Text(SearchScope.library.rawValue).tag(SearchScope.library)
					}
				}

				.onSubmit(of: .search) {
					searchObservableObject.searchSubmit = true
				}

				.onChange(of: searchTerm) { term in
					searchObservableObject.searchTerm = term
				}

				.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
					searchObservableObject.searchSubmit = false
					searchObservableObject.selectedMediaType = .topResult
				}
		}
	}
}

struct SearchOrCategoryView: View {
	@Environment(\.isSearching) private var isSearching
	@ObservedObject var searchObservableObject: SearchObservableObject

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

/// For search scope to be shown on search activation.
extension UISearchController {
	open override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		self.scopeBarActivation = .onSearchActivation
	}
}

// MARK: - Search Results View

extension SearchOrCategoryView {
	var searchResults: some View {
		ZStack {
			VStack(spacing: .zero) {
				if searchObservableObject.searchSubmit {
					Group {
						MediaKindSegmentedControl(searchObservableObject: searchObservableObject)
					}
					.padding(.vertical, 10)
					.background(.ultraThinMaterial)
					.zIndex(.infinity)
				}
				SearchListView(searchObservableObject: searchObservableObject).padding(.top, 1)

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
}

// MARK: - Types

enum SearchScope: String, CaseIterable {
	case appleMusic = "Apple Music"
	case library = "Your Library"

	var prompt: String {
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
