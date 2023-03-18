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
	private(set) var albumReleaseDate: String = ""
	
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

	var trackCount: Int {
		guard !tracks.isEmpty else { return 0 }
		return tracks.count
	}

	var album: Media? {
		guard !trackResults.isEmpty else { return nil }
		var tracks = trackResults
		return tracks.removeFirst()
	}
	
	// MARK: - Initialization
	
	init(networkService: NetworkService = .init()) {
		self.networkService = networkService
		$trackResults
			.map(\.isEmpty)
			.assign(to: &$loadingTracks)
	}
	
	// MARK: - Public Methods

	@MainActor
	func fetchTracks(for collectionId: String) {
		cleanErrorState()

		networkService.request(endpoint: .getInfo(by: .lookup(id: collectionId, entity: "song",  media: "music", attribute: "songTerm")))
			.compactMap { $0 as ITunesAPIResponse }
			.catch(handleError)
				.map(\.results)
				.map { $0.map(Media.init) }

			.assign(to: &$trackResults)
	}

	@MainActor
	func playTrack(withId id: String) {
		PlayerObservableObject.audioPlayer.stop()
		PlayerObservableObject.audioPlayer.setQueue(with: [id])
		UserDefaults.standard.set([id], forKey: UserDefaultsKey.queueDefault)
		PlayerObservableObject.audioPlayer.play()
		PlayerObservableObject.setShuffleMode(false)
	}

	@MainActor
	func playAllTracks(isShuffle: Bool) {
		configureAlbumDetails()
		PlayerObservableObject.audioPlayer.stop()
		PlayerObservableObject.audioPlayer.setQueue(with: trackIDsQueue)

		UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
		PlayerObservableObject.setShuffleMode(isShuffle)
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
		self.albumReleaseDate = album?.releaseDate ?? ""
		self.albumDuration = (albumDuration / 60).rounded(.up).toInt
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
