//
//  GlobalSearchObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 10.05.2022.
//

import Foundation
import Combine

final class GlobalSearchObservableObject: ObservableObject {

  // MARK: - Properties

  private let networkService: NetworkServiceProtocol
  private var anyCancellable: Set<AnyCancellable> = []

  var genresResult: [String] {
    Set(globalSearchResult.map(\.genreName)).sorted()
  }

  var nothingFoundTitle: String {
    "Nothing found with: " + searchQuery
  }

  var isEmptyQuery: Bool {
    searchQuery.count < 2
  }

  // MARK: - Publishers

  @Published private(set) var presenter: Presenter? = .none
  @Published private(set) var globalSearchResult: [Media] = []
  @Published private(set) var isSearching = false
  @Published private(set) var nothingFound = false

  @Published var searchQuery = ""

  // MARK: - Init

  init(networkService: NetworkServiceProtocol = NetworkService()) {
    self.networkService = networkService
    chain()
  }

  // MARK: - Methods

  func sortedBy(genre: String) -> [Media] {
    globalSearchResult.filter { $0.genreName == genre }
  }
}

private extension GlobalSearchObservableObject {
  func chain() {
    $searchQuery
      .debounce(for: .seconds(1), scheduler: RunLoop.main)
      .filter(validSearching)
      .flatMap(search)
      .map { $0.map(Media.init) }
      .replaceError(with: [])
      .assign(to: &$globalSearchResult)
    $searchQuery
      .map(validSearching)
      .assign(to: &$isSearching)
    $globalSearchResult
      .map(\.isEmpty)
      .assign(to: &$nothingFound)
  }

  func search(searchQuery: String) -> AnyPublisher<[MediaResponse], NetworkError> {
    networkService.request(endpoint: .getInfo(by: .search(term: searchQuery, country: "US", entity: "song", media: "music")))
      .map { $0 as ITunesAPIResponse }
      .map(\.results)
      .map(loaded)
      .eraseToAnyPublisher()
  }

  func validSearching(with query: String) -> Bool {
    globalSearchResult = []
    return query.count > 1
  }

  func loaded(results: [MediaResponse]) -> [MediaResponse] {
    isSearching = false
    return results
  }
}
