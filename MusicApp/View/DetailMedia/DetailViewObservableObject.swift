//
//  DetailViewObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import Combine

final class DetailViewObservableObject: ObservableObject {
    
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    private var anyCancellable: Set<AnyCancellable> = []
    
    // MARK: - Publishers
    
    @Published private(set) var detailResults: [Media] = []
    
    @Published var toDetail: ToDetail?
    @Published var isLoading: Bool = false
    @Published var errorState: ErrorState = .init(isError: false, descriptor: nil)
    @Published var presenter: Presenter? = nil
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
        $detailResults
            .map(\.isEmpty)
            .assign(to: &$isLoading)
    }
    
    // MARK: - Public Methods
    
    func fetchDetail(mediaId: String) {
        guard detailResults.isEmpty else { return }
        cleanErrorState()
        networkService.request(endpoint: .getInfo(by: .detail(id: mediaId, entity: "song")))
            .compactMap { $0 as ITunesAPIResponse }
            .catch(handleError)
            .map(\.results)
            .map { $0.map(Media.init) }
            .assign(to: &$detailResults)
    }
}

// MARK: - Private methods

private extension DetailViewObservableObject {
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
        guard errorState.isError else {
            return
        }
        errorState = .init(isError: false, descriptor: nil)
    }
}
