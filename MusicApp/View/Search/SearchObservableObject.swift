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
  private var media: [Media] = []

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
  @Published var mediaKind: MediaKind = .album

  // MARK: - Initialization

  init(networkService: NetworkServiceProtocol = NetworkService()) {
    self.networkService = networkService

    $sortType
      .map { $0 == .search(searchTerm: "") }
      .map { _ in return "" }
      .assign(to: &$currentGenre)

    chain()
  }

  // MARK: - Public Methods

  func select(_ mediaKind: MediaKind) {
    sortType = .filter(iD: mediaKind.title)
    self.mediaKind = mediaKind

    chain()
  }
}

// MARK: - Private Methods

private extension SearchObservableObject {
  func chain() {
    $searchTerm
      .debounce(for: .seconds(0.6), scheduler: RunLoop.main)
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
    networkService.request(endpoint: .getInfo(by: .search(term: searchQuery, entity: mediaKind.entity, media: "music")))
      .map { $0 as ITunesAPIResponse }
      .map(\.results)
      .map(loaded)
      .eraseToAnyPublisher()
  }

  func validSearching(with query: String) -> Bool {
    searchResults = []
    return query.count > 0
  }

  func loaded(results: [MediaResponse]) -> [MediaResponse] {
    searchLoading = false
    return results
  }

  func handleResult() -> [Media] {
    let media = self.media.reduce([Media]()) { result, media in
      result.contains(media) ? result : result + [media]
    }
    return media
  }

  func handleError(_ networkError: NetworkError) -> Empty<ITunesAPIResponse, Never> {
    .init()
  }
}
