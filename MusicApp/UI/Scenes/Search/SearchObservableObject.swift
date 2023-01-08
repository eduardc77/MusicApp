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

	private let networkService: NetworkServiceProtocol
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
	@Published var searchTerm = ""
	@Published var currentGenre = ""
	@Published var searchPrompt: SearchPrompt = .appleMusic
	@Published var searchSubmit = false
	@Published var sortType: SortingType = .noSorting
	@Published var selectedMediaType: MediaType = .topResult

	// MARK: - Initialization

	init(networkService: NetworkServiceProtocol = NetworkService()) {
		self.networkService = networkService

		$sortType
			.map { $0 == .search(searchTerm: "") }
			.map { _ in return "" }
			.assign(to: &$currentGenre)

		chainSearch
	}

	// MARK: - Public Methods

	func select(_ mediaKind: MediaType) {
		sortType = .filter(iD: mediaKind.title)
		self.selectedMediaType = mediaKind

		chainSearch
	}

	var chainTopResultsSearch: Void {
		guard selectedMediaType == .topResult else { return }

	}

}

// MARK: - Private Methods

private extension SearchObservableObject {
	var chainSearch: Void {
		$searchTerm
			.debounce(for: .seconds(0.3), scheduler: RunLoop.main)
			.filter(validSearching)
			.flatMap(search)
			.map { $0.map(Media.init) }
			.replaceError(with: [])
			.assign(to: &$searchResults)
		$searchTerm
			.map(validSearching)
			.assign(to: &$searchLoading)
		$searchResults
			.map(\.isEmpty)
			.assign(to: &$nothingFound)
	}

	func search(searchQuery: String) -> AnyPublisher<[MediaResponse], NetworkError> {
		networkService.request(endpoint: .getInfo(by: .search(term: searchQuery, entity: selectedMediaType.entity.first, media: "music")))
			  .map { $0 as ITunesAPIResponse }
			  .map(\.results)
			  .map(loaded)
			  .eraseToAnyPublisher()
	}

	func validSearching(with query: String) -> Bool {
		return query.count > 0
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
