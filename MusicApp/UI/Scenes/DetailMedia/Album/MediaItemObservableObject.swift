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
		cleanErrorState()

		networkService.request(endpoint: .getInfo(by: .lookup(id: collectionId, entity: "song",  media: "music", attribute: "songTerm")))
			.compactMap { $0 as ITunesAPIResponse }
			.catch(handleError)
				.map(\.results)
				.map { $0.map(Media.init) }

			.assign(to: &$trackResults)
	}
	
	func playTrack(withId id: String) {
		PlayerObservableObject.audioPlayer.stop()
		PlayerObservableObject.audioPlayer.setQueue(with: [id])
		UserDefaults.standard.set([id], forKey: UserDefaultsKey.queueDefault)

		PlayerObservableObject.audioPlayer.play()
		PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.off
		UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
	}
	
	func playAllTracks(isShuffle: Bool) {
		configureAlbumDetails()
		PlayerObservableObject.audioPlayer.stop()
		PlayerObservableObject.audioPlayer.setQueue(with: trackIDsQueue)

		UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
		if isShuffle {
			PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.songs
			UserDefaults.standard.set(true, forKey: UserDefaultsKey.shuffleDefault)
			PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.songs
		} else {
			UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
			PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.off
		}
		PlayerObservableObject.audioPlayer.play()
	}
	
	func configureAlbumDetails() {
		var albumDuration: TimeInterval = 0
		trackIDsQueue.removeAll()

		tracks.forEach { track in
			trackIDsQueue.append(String(track.trackId))
			albumDuration += Double(track.playbackDuration)
			albumTrackCount += 1
		}
		self.albumDuration = Int((albumDuration / 60).rounded(.up))
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
