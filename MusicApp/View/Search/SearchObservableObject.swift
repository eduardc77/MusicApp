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
    

    
    // MARK: - Publishers
    
    @Published private(set) var searchResults: [Media] = []
    @Published private(set) var isSearching = false
    @Published private(set) var nothingFound = false
    
    @Published var sortType: SortingType = .noSorting
    @Published var searchTerm = ""
    @Published var currentGenre: String = ""
    
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
//        fetchMedia()
        
        $sortType
            .map { $0 == .search(searchTerm: "") }
            .map { _ in return "" }
            .assign(to: &$currentGenre)
        
        chain()
    }
    
    // MARK: - Public Methods
    
    func select(_ genre: String) {
        sortType = .filter(iD: genre)
        if !searchTerm.isEmpty {
            searchTerm = ""
        }
        currentGenre = genre
    }
}

// MARK: - Private Methods

private extension SearchObservableObject {
    func chain() {
        $searchTerm
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .flatMap(search)
            .map { $0.map(Media.init) }
            .replaceError(with: [])
            .assign(to: &$searchResults)
        
        $searchResults
            .map(\.isEmpty)
            .assign(to: &$nothingFound)
    }
    
    func search(searchQuery: String) -> AnyPublisher<[MediaResponse], NetworkError> {
        networkService.request(endpoint: .getInfo(by: .search(term: searchQuery, country: "US", entity: "allArtist", media: "music")))
            .map { $0 as ITunesAPIResponse }
            .map(\.results)
            .map(loaded)
            .eraseToAnyPublisher()
    }
    
    func loaded(results: [MediaResponse]) -> [MediaResponse] {
        isSearching = false
        return results
    }
    
//    func fetchMedia() {
//        ["love"].forEach { item in
//            networkService
//                .request(endpoint: .getInfo(by: .search(term: item, country: "US", entity: "movie", media: "music")))
//                .map { $0 as ITunesAPIResponse }
//                .catch(handleError)
//                .map { self.media.append(contentsOf: $0.results.map(Media.init)) }
//                .map(handleResult)
//                .assign(to: &$mediasResult)
//        }
//    }
    
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
