//
//  SearchObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation
import Combine

class SearchObservableObject: ObservableObject {
    typealias ImageInfo = (url: URL, data: Data)
    
    @Published var searchTerm: String = ""
    @Published var searchResults: [Media] = []
    @Published var imagesData: [URL: Data] = [:]
    @Published var showErrorAlert = false
    @Published var isLoadingMore = false
    @Published var mediaType = MediaKind.song
    @Published var noResultsFound = false
    
    private var subscriptions = Set<AnyCancellable>()
    private var requestSubscription: AnyCancellable?
    private var resultIds: [String: String] = [:]
    private var previousQuery: SearchQuery?
    private var queryLimit: Int = 30
    private var loadingMoreComplete = false
    
    var urlSession: URLSession
    var errorMessage: String?
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func search() {
        $searchTerm
            .debounce(for: 0.6, scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    return nil
                }
                
                return string.trimmingCharacters(in: .whitespacesAndNewlines)
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { _ in
                //
            } receiveValue: { [self] (searchField) in
                let newQuery = SearchQuery(term: searchField,
                                           media: mediaType,
                                           limit: queryLimit)
                
                if let previousQuery = previousQuery,
                   previousQuery.term == newQuery.term,
                   previousQuery.media == newQuery.media {
                    // duplicate search
                    return
                }
                resetSearch()
                previousQuery = newQuery
                sendRequest(with: newQuery)
            }
            .store(in: &subscriptions)
    }
    
    func loadMore() {
        guard !loadingMoreComplete, searchResults.count >= queryLimit else {
            stopLoadingMore()
            return
        }
        
        if var query = previousQuery {
            isLoadingMore = true
            query.offset = searchResults.count
            previousQuery = query
            sendRequest(with: query)
            return
        }
    }
}

// MARK: - Private Methods

private extension SearchObservableObject {
    func sendRequest(with query: SearchQuery) {
        let apiManager = APIManager<ITunesAPIResponse>(
            path: .search(query),
            urlSession: urlSession
        )
        requestSubscription = apiManager.send()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleSearchError(error)
                }
            } receiveValue: { [weak self] apiResponse in
                self?.handleSearchResults(apiResponse.results)
            }
    }
    
    func sendImageRequest(url: URL) {
        guard imagesData[url] == nil else { return }
        
        let apiManager = APIManager<Void>(
            path: .image(url),
            urlSession: urlSession
        )
        apiManager.sendForImage()
            .sink { data in
                if !data.isEmpty {
                    self.imagesData[url] = data
                }
            }
            .store(in: &subscriptions)
    }
    
    func handleSearchResults(_ results: [Media]) {
        guard results.count > 0 else {
            stopLoadingMore()
            if !isLoadingMore {
                noResultsFound = true
            }
            return
        }
        
        // iTunes Search API often returns duplicates
        // remove duplicates by id.
        var newResults: [Media] = []
        
        for item in results where resultIds[item.id] != item.id {
            resultIds[item.id] = item.id
            newResults.append(item)
            sendImageRequest(url: item.artworkUrl100)
        }
        
        guard newResults.count > 0 else {
            stopLoadingMore()
            return
        }
        searchResults += newResults
    }
    
    func resetSearch() {
        searchResults = []
        resultIds = [:]
        errorMessage = nil
        previousQuery = nil
        isLoadingMore = false
        loadingMoreComplete = false
        noResultsFound = false
    }
    
    func stopLoadingMore() {
        isLoadingMore = false
        loadingMoreComplete = true
    }
    
    func handleSearchError(_ error: Error) {
        errorMessage = error.localizedDescription
        showErrorAlert = true
        isLoadingMore = false
        // allow user to retry the same search due to the error
        previousQuery = nil
    }
}
