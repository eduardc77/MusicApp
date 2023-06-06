//
//  SearchObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation
import Combine

final class SearchObservableObject: ObservableObject {

	// MARK: - Properties

	private let networkService: NetworkServiceProtocol = NetworkService()
	private var anyCancellable: Set<AnyCancellable> = []

	var filteredContent: [Media] {
		switch sortType {
		case .noSorting:
			return searchResults
		case let .search(searchTerm):
			guard !searchTerm.isEmpty else { return searchResults }
			return searchResults.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
		case let .filter(iD):
			return searchResults.filter { $0.genreName == iD }
		}
	}

	var genresResult: [String] {
		Set(searchResults.map(\.genreName)).sorted()
	}

	var searchLoadedWithNoResults: Bool {
		guard nothingFound, !searchLoading, searchTerm.count > 0 else { return false }
		return true
	}

	// MARK: - Publishers

	@Published private(set) var searchResults: [Media] = []
	@Published private(set) var searchLoading = false
	@Published private(set) var nothingFound = false
	@Published private(set) var currentGenre = ""
	@Published private(set) var sortType: SortingType = .noSorting
	@Published var selectedMediaType: MediaType = .topResult
	@Published var searchPrompt: SearchPrompt = .appleMusic
	@Published var searchSubmit = false
	@Published var searchTerm = ""

	// MARK: - Initialization

	init() {
		select(.topResult)
	}

	// MARK: - Public Methods

	func select(_ mediaKind: MediaType) {
		sortType = .filter(iD: mediaKind.title)
		selectedMediaType = mediaKind
		chainSearch
	}

	var chainTopResultsSearch: Void {
		guard selectedMediaType == .topResult else { return }
	}
}

// MARK: - Private Methods

private extension SearchObservableObject {
	
	var chainSearch: Void {
		let debounceSeconds = selectedMediaType == .topResult ? 0.6 : 0.4

		$searchTerm
			.debounce(for: .seconds(debounceSeconds), scheduler: RunLoop.main)
			.filter(validSearching)
			.flatMap(search)
			.map { $0.map(Media.init) }
			.replaceError(with: .init())
			.sink { [weak self] results in
				self?.searchResults = results
			}
			.store(in: &anyCancellable)

		$searchTerm
			.map(validSearching)
			.sink { [weak self] results in
				self?.searchLoading = results
			}
			.store(in: &anyCancellable)
		$searchResults
			.map(\.isEmpty)
			.sink { [weak self] results in
				self?.nothingFound = results
			}
			.store(in: &anyCancellable)
	}

	func search(searchQuery: String) -> AnyPublisher<[MediaResponse], NetworkError> {
		networkService.request(endpoint: .getInfo(by: .search(term: searchQuery, entity: selectedMediaType.entity.first, media: "music")))
			  .map { $0 as ITunesAPIResponse }
			  .map(\.results)
			  .map(loaded)
			  .eraseToAnyPublisher()
	}

	func validSearching(with query: String) -> Bool {
		query.count > 0
	}

	func loaded(results: [MediaResponse]) -> [MediaResponse] {
		searchLoading = false
		return results
	}

	func handleResult(results: [Media]) -> [Media] {
		let media = results.reduce([Media]()) { result, media in
			result.contains(media) ? result : result + [media]
		}
		return media
	}

	func handleError(_ networkError: NetworkError) -> Empty<ITunesAPIResponse, Never> { .init() }
}
