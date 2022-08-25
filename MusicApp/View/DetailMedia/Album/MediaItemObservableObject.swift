//
//  MediaItemObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import Combine
import MediaPlayer

final class MediaItemObservableObject: ObservableObject {
  // MARK: - Properties
  
  private let networkService: NetworkServiceProtocol
  private var anyCancellable: Set<AnyCancellable> = []
  private var player = MPMusicPlayerController.applicationMusicPlayer
  private(set) var albumDuration: Int = 0
  private(set) var albumTrackCount: Int = 0
  
  // MARK: - Publishers
  
  @Published private var trackIDsQueue: [String] = []
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
  
  func fetchTracks(for collectionId: String) {
    guard trackResults.isEmpty else { return }
    cleanErrorState()
    
    networkService.request(endpoint: .getInfo(by: .lookup(id: collectionId, entity: "song",  media: "music", attribute: "songTerm")))
      .compactMap { $0 as ITunesAPIResponse }
      .catch(handleError)
        .map(\.results)
        .map { $0.map(Media.init) }
      .assign(to: &$trackResults)
  }
  
  func playTrack(withId id: String) {
    player.stop()
    player.setQueue(with: [id])
    player.play()
    UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
    player.shuffleMode = MPMusicShuffleMode.off
  }
  
  func playAllTracks(isShuffle: Bool) {
    configureAlbumDetails()
    
    player.stop()
    player.setQueue(with: trackIDsQueue)
    UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
    
    if isShuffle {
      player.shuffleMode = MPMusicShuffleMode.songs
      UserDefaults.standard.set(true, forKey: UserDefaultsKey.shuffleDefault)
      player.shuffleMode = MPMusicShuffleMode.songs
    } else {
      UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
      player.shuffleMode = MPMusicShuffleMode.off
    }
    
    player.play()
  }
  
  func configureAlbumDetails() {
    var albumDuration: TimeInterval = 0
    
    trackIDsQueue.removeAll()
    tracks.forEach { track in
      trackIDsQueue.append(track.id)
      albumDuration += Double(track.duration) ?? 0
      albumTrackCount += 1
    }
    
    self.albumDuration = Int((albumDuration / 60).truncatingRemainder(dividingBy: 60))
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
