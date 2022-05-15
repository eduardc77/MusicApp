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
    @Published private(set) var musicVideoResults: [Media] = []
    @Published private(set) var isLoadingAlbums: Bool = false
    @Published private(set) var isLoadingSongs: Bool = false
    @Published private(set) var isLoadingMusicVideos: Bool = false
    @Published private(set) var presenter: Presenter? = nil
    @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
    
    var albums: [Media] {
        guard !albumResults.isEmpty else { return [] }
        
        var albums = albumResults
        albums.removeFirst()
        
        return albums
    }
    
    var songs: [Media] {
        guard !songResults.isEmpty else { return [] }
        
        var songs = songResults
        songs.removeFirst()
        
        return songs
    }
    
    var musicVideos: [Media] {
        guard !musicVideoResults.isEmpty else { return [] }
        
        var musicVideos = musicVideoResults
        musicVideos.removeFirst()
        
        return musicVideos
    }
    
    
    var loadingComplete: Bool {
        if isLoadingSongs, isLoadingAlbums, isLoadingMusicVideos {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
        $albumResults
            .map(\.isEmpty)
            .assign(to: &$isLoadingAlbums)
        $songResults
            .map(\.isEmpty)
            .assign(to: &$isLoadingSongs)
        $musicVideoResults
            .map(\.isEmpty)
            .assign(to: &$isLoadingMusicVideos)
    }
    
    // MARK: - Public Methods
    
    func fetchAllArtistMedia(for artistId: String) {
        fetchAlbums(for: artistId)
        fetchSongs(for: artistId)
        fetchMusicVideos(for: artistId)
    }
    
    func fetchAlbums(for artistId: String) {
        guard albumResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "album", sort: "recent")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$albumResults)
    }
    
    func fetchSongs(for artistId: String) {
        guard songResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "song", sort: "recent")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$songResults)
    }
    
    func fetchMusicVideos(for artistId: String) {
        guard songResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "musicVideo", limit: "5")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$musicVideoResults)
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
