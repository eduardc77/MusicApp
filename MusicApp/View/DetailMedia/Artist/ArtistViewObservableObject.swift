//
//  ArtistViewObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import Combine

final class ArtistViewObservableObject: ObservableObject {
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    private var anyCancellable: Set<AnyCancellable> = []
    
    // MARK: - Publishers
    
    @Published private(set) var albumResults: [Media] = []
    @Published private(set) var songResults: [Media] = []
    
    @Published var isLoading: Bool = false
    @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
    @Published var presenter: Presenter? = nil
    
    var albums: [Media] {
        var albums = albumResults
        albums.removeFirst()
        
        return albums
    }
    
    var songs: [Media] {
        var songs = songResults
        songs.removeFirst()
        
        return songs
    }
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
        $albumResults
            .map(\.isEmpty)
            .assign(to: &$isLoading)
        
        $songResults
            .map(\.isEmpty)
            .assign(to: &$isLoading)
    }
    
    // MARK: - Public Methods
    
    func fetchArtistAlbums(for artistId: String) {
        guard albumResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "album")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
            .assign(to: &$albumResults)
    }
    
    func fetchArtistSongs(for artistId: String) {
        guard songResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "song", limit: "5", sort: "recent")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
            .assign(to: &$songResults)
    }
}

// MARK: - Private methods

private extension ArtistViewObservableObject {
    func handleError(_ error: NetworkError) -> Empty<ITunesAPIResponse, Never> {
        errorState = .init(
            isError: true,
            descriptor: .init(
                title: error.errorTitle,
                description: error.localizedDescription
            )
        )
        return .init()
    }
    
    func cleanErrorState() {
        guard errorState.isError else { return }
        errorState = .init(isError: false, descriptor: nil)
    }
}
