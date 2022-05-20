//
//  MediaItemObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import Combine

final class MediaItemObservableObject: ObservableObject {
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    private var anyCancellable: Set<AnyCancellable> = []
    
    // MARK: - Publishers

    @Published private(set) var trackResults: [Media] = []
    @Published private(set) var loadingTracks: Bool = false
    @Published private(set) var presenter: Presenter? = nil
    @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
    
    var tracks: [Media] {
        guard !trackResults.isEmpty else { return [] }
        
        var tracks = trackResults
        tracks.removeFirst()
        
        return tracks
    }
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
        $trackResults
            .map(\.isEmpty)
            .assign(to: &$loadingTracks)
    }
    
    // MARK: - Public Methods
    
    func fetchSongs(for collectionId: String) {
        guard trackResults.isEmpty else { return }
        cleanErrorState()
        
        networkService.request(endpoint: .getInfo(by: .lookup(id: collectionId, entity: "song", media: "music", attribute: "songTerm")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
                .map(\.results)
                .map { $0.map(Media.init) }
            .assign(to: &$trackResults)
    }
}

// MARK: - Private methods

private extension MediaItemObservableObject {
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
