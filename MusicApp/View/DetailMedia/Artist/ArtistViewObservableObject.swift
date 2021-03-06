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

    @Published private(set) var trackResults: [Media] = []
    @Published private(set) var albumResults: [Media] = []
    @Published private(set) var musicVideoResults: [Media] = []
    @Published private(set) var loadingTracks: Bool = false
    @Published private(set) var loadingAlbums: Bool = false
    @Published private(set) var loadingMusicVideos: Bool = false
    @Published private(set) var presenter: Presenter? = nil
    @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
    
    var tracks: [Media] {
        guard !trackResults.isEmpty else { return [] }
        
        var tracks = trackResults
        tracks.removeFirst()
        
        return tracks
    }
    
    var albums: [Media] {
        guard !albumResults.isEmpty else { return [] }
        
        var albums = albumResults
        albums.removeFirst()
        
        return albums
    }
    
    var musicVideos: [Media] {
        guard !musicVideoResults.isEmpty else { return [] }
        
        var musicVideos = musicVideoResults
        musicVideos.removeFirst()
        
        return musicVideos
    }
    
    
    var loadingComplete: Bool {
        if loadingTracks || loadingAlbums || loadingMusicVideos {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
        $trackResults
            .map(\.isEmpty)
            .assign(to: &$loadingTracks)
        $albumResults
            .map(\.isEmpty)
            .assign(to: &$loadingAlbums)
        $musicVideoResults
            .map(\.isEmpty)
            .assign(to: &$loadingMusicVideos)
    }
    
    // MARK: - Public Methods
    
    func fetchAllArtistMedia(for artistId: String) {
        fetchSongs(for: artistId)
        fetchAlbums(for: artistId)
        fetchMusicVideos(for: artistId)
    }
    
    func fetchSongs(for artistId: String) {
        guard trackResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "song", media: "music", attribute: "songTerm", limit: "100", sort: "recent")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$trackResults)
    }
    
    func fetchAlbums(for artistId: String) {
        guard albumResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "album", media: "music", attribute: "albumTerm", limit: "100", sort: "recent")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$albumResults)
    }
    
    func fetchMusicVideos(for artistId: String) {
        guard musicVideoResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: artistId, entity: "musicVideo", media: "musicVideo", attribute: "songTerm", limit: "100", sort: "recent")))
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
