//
//  SearchViewModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
   
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
   
   var artists: [Media] = []
   var albums: [Media] = []
   var songs: [Media] = []
   var musicVideos: [Media] = []
   var music: [Media] = []
   var podcasts: [Media] = []
   var podcastAuthors: [Media] = []
   var movies: [Media] = []
   var tvShows: [Media] = []
   var shortFilms: [Media] = []
   var audiobooks: [Media] = []
   var ebooks: [Media] = []
   
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
   
   deinit {
      print("deinit SearchViewModel")
   }
   
   // MARK: - Public Methods
   
   func select(_ mediaKind: MediaType) {
      sortType = .filter(iD: mediaKind.title)
      selectedMediaType = mediaKind
      
      switch mediaKind {
         case .topResult: break
         case .artist:
            if !artists.isEmpty { return searchResults = artists }
         case .album:
            if !albums.isEmpty { return searchResults = albums }
         case .song:
            if !songs.isEmpty { return searchResults = songs }
         case .musicVideo:
            if !musicVideos.isEmpty { return searchResults = musicVideos }
         case .music:
            if !music.isEmpty { return searchResults = music }
         case .podcast:
            if !podcasts.isEmpty { return searchResults = podcasts }
         case .podcastAuthor:
            if !podcastAuthors.isEmpty { return searchResults = podcastAuthors }
         case .movie:
            if !movies.isEmpty { return searchResults = movies }
         case .tvShow:
            if !tvShows.isEmpty { return searchResults = tvShows }
         case .shortFilm:
            if !shortFilms.isEmpty { return searchResults = shortFilms }
         case .audiobook:
            if !audiobooks.isEmpty { return searchResults = audiobooks }
         case .ebook:
            if !ebooks.isEmpty { return searchResults = ebooks }
      }
      chainSearch
   }
   
   var chainTopResultsSearch: Void {
      guard selectedMediaType == .topResult else { return }
   }
   
   func resetChachedContent() {
      artists = []
      albums = []
      songs = []
      musicVideos = []
      music = []
      podcasts = []
      podcastAuthors = []
      movies = []
      tvShows = []
      shortFilms = []
      audiobooks = []
      ebooks = []
   }
   
   func removeSearchResults() {
      searchResults.removeAll()
   }
}

// MARK: - Private Methods

private extension SearchViewModel {
   
   var chainSearch: Void {
      $searchTerm
         .debounce(for: selectedMediaType == .topResult ? .seconds(0.4) : .seconds(0.6), scheduler: RunLoop.main)
         .filter(validSearching)
         .removeDuplicates()
         .flatMap(search)
         .map { $0.map(Media.init) }
         .replaceError(with: .init())
         .sink { [weak self] results in
            guard let self = self else { return }
            DispatchQueue.main.async {
               self.searchResults = results
               
               switch self.selectedMediaType {
                  case .topResult:
                     break
                  case .artist:
                     self.artists = self.searchResults
                  case .album:
                     self.albums = self.searchResults
                  case .song:
                     self.songs = self.searchResults
                  case .musicVideo:
                     self.musicVideos = self.searchResults
                  case .music:
                     self.music = self.searchResults
                  case .podcast:
                     self.podcasts = self.searchResults
                  case .podcastAuthor:
                     self.podcastAuthors = self.searchResults
                  case .movie:
                     self.movies = self.searchResults
                  case .tvShow:
                     self.tvShows = self.searchResults
                  case .shortFilm:
                     self.shortFilms = self.searchResults
                  case .audiobook:
                     self.audiobooks = self.searchResults
                  case .ebook:
                     self.ebooks = self.searchResults
               }
            }
         }
         .store(in: &anyCancellable)
      
      $searchTerm
         .map(validSearching)
         .sink { [weak self] results in
            DispatchQueue.main.async {
               self?.searchLoading = results
            }
         }
         .store(in: &anyCancellable)
      $searchResults
         .map(\.isEmpty)
         .sink { [weak self] results in
            guard let self = self else { return }
            DispatchQueue.main.async {
               self.nothingFound = results
            }
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
      if query.count == 0 { searchResults.removeAll() }
      return query.count > 0
   }
   
   func loaded(results: [MediaResponse]) -> [MediaResponse] {
      DispatchQueue.main.async {
         self.searchLoading = false
      }
      
      return results
   }
}
