//
//  PlayerObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI
import MediaPlayer
import Combine

enum PlayerType {
	case video
	case audio
}

final class PlayerObservableObject: ObservableObject {
	static let audioPlayer = MPMusicPlayerController.applicationMusicPlayer
	
	@Published var expand: Bool = false
	@Published var hasRecentMedia: Bool = false
	@Published var showPlayerView = false
	var playerType: PlayerType = .audio
	
	// MARK: - Audio Player Properties
	
	@Published var nowPlayingItem: Media = Media()
	@Published var playbackState: MPMusicPlaybackState = .stopped
	@Published var playerOption = PlayerOption()
	@Published var progressRate: Int = 0
	private var musicPlayerPlayingCancellable: AnyCancellable?
	
	// MARK: - Video Player Properties
	
	var videoPlayer: VideoPlayerView = VideoPlayerView(videoAssetUrl: URL(string: "https://www.apple.com/404")!)
	var videoMedia: Bool = false

	init() {
		musicPlayerPlayingCancellable = $hasRecentMedia.sink
		{ [weak self] in
			if $0 || self?.playbackState == .playing && self?.showPlayerView == false {
				self?.showPlayerView = true
			}
		}
	}
	
	// MARK: - Public Methods
	
	func initPlayerFromUserDefaults() {
		switch (UserDefaults.standard.integer(forKey: UserDefaultsKey.repeatDefault)) {
		case 0:
			PlayerObservableObject.audioPlayer.repeatMode = .none
			playerOption.repeatMode = .noRepeat
		case 1:
			PlayerObservableObject.audioPlayer.repeatMode = .all
			playerOption.repeatMode = .albumRepeat
		case 2:
			PlayerObservableObject.audioPlayer.repeatMode = .one
			playerOption.repeatMode = .oneSongRepeat
		default:
			PlayerObservableObject.audioPlayer.repeatMode = .none
			playerOption.repeatMode = .noRepeat
		}
		
		if let recentMedia = UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) as? [String] {
			PlayerObservableObject.audioPlayer.setQueue(with: recentMedia)
			PlayerObservableObject.audioPlayer.prepareToPlay()
			hasRecentMedia = true
		}
		
		if UserDefaults.standard.bool(forKey: UserDefaultsKey.shuffleDefault) {
			PlayerObservableObject.audioPlayer.shuffleMode = MPMusicShuffleMode.songs
		}
	}
	
	func changeRepeatMode() -> MPMusicRepeatMode {
		playerOption.repeatMode = playerOption.repeatMode.next()
		
		switch playerOption.repeatMode {
		case .noRepeat:
			UserDefaults.standard.set(0, forKey: UserDefaultsKey.repeatDefault)
			return MPMusicRepeatMode.none
		case .albumRepeat:
			UserDefaults.standard.set(1, forKey: UserDefaultsKey.repeatDefault)
			return MPMusicRepeatMode.all
		case .oneSongRepeat:
			UserDefaults.standard.set(2, forKey: UserDefaultsKey.repeatDefault)
			return MPMusicRepeatMode.one
		}
	}
	
	func setNowPlaying(media: MPMediaItem? = nil, videoAssetUrl: URL? = nil) {
		guard let media = media else { return }
		
		let mediaKind: MediaKind

		switch media.mediaType {
		case .music: mediaKind = .song
		case .podcast: mediaKind = .podcastEpisode
		case .audioBook: mediaKind = .ebook
		case .anyAudio: mediaKind = .song
		case .movie: mediaKind = .featureMovie
		case .videoPodcast: mediaKind = .podcastEpisode
		case .tvShow: mediaKind = .tvEpisode
		case .musicVideo: mediaKind = .musicVideo
		case .anyAudio: mediaKind = .song
		case .audioITunesU: mediaKind = .song
		case .videoITunesU: mediaKind = .musicVideo
		case .homeVideo: mediaKind = .musicVideo
		case .anyVideo: mediaKind = .musicVideo
		case .any: mediaKind = .song
		default: mediaKind = .song
		}
		
		nowPlayingItem = Media(mediaResponse: MediaResponse(id: media.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: mediaKind.value, name: media.title, artistName: media.artist, collectionName: media.albumTitle, trackName: media.title, collectionCensoredName: media.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: videoAssetUrl?.absoluteString ?? media.assetURL?.absoluteString, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: media.isExplicitItem ? "explicit" : "notExplicit", discCount: 0, discNumber: nil, trackCount: media.albumTrackCount, trackNumber: media.albumTrackNumber, trackTimeMillis: media.playbackDuration, country: nil, currency: nil, primaryGenreName: media.genre, description: nil, longDescription: nil, releaseDate: media.releaseDate?.ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 0, artwork: media.artwork?.image(at: CGSize(width: 1024, height: 1024)), composer: media.composer, isCompilation: media.isCompilation))

		if !videoMedia {
			playerType = .audio
		}
	}
	
	func configureVideoPlayer(with videoAssetUrl: URL) {
		playerType = .video
		PlayerObservableObject.audioPlayer.stop()
		PlayerObservableObject.audioPlayer.nowPlayingItem = nil

		videoPlayer = VideoPlayerView(videoAssetUrl: videoAssetUrl)
		expand = true
		showPlayerView = true
	}
	
	func isNowPlaying(media: Media) -> Bool {
		return (media.trackName == nowPlayingItem.trackName &&
				  media.collectionName == nowPlayingItem.collectionName &&
				  media.artistName == nowPlayingItem.artistName)
	}

	func play(_ media: Media, videoAssetUrl: URL? = nil) {
		videoMedia = media.mediaType == .musicVideo

		if videoMedia == false {
			self.playerType = .audio
			PlayerObservableObject.audioPlayer.stop()
			PlayerObservableObject.audioPlayer.setQueue(with: [media.id])
			PlayerObservableObject.setShuffleMode(false)
			PlayerObservableObject.audioPlayer.play()
		} else {
			configureVideoPlayer(with: videoAssetUrl ?? URL(string: "https://www.apple.com/404")!)
		}
	}

	static func setShuffleMode(_ value: Bool) {
		UserDefaults.standard.set(value, forKey: UserDefaultsKey.shuffleDefault)
		PlayerObservableObject.audioPlayer.shuffleMode = value ? MPMusicShuffleMode.songs : MPMusicShuffleMode.off
	}
}

// MARK: - Types

extension PlayerObservableObject {
	enum RepeatMode: CaseIterable {
		case noRepeat
		case albumRepeat
		case oneSongRepeat
	}
	
	struct PlayerOption {
		var repeatMode: RepeatMode = .noRepeat
		var isShuffle: Bool = false
	}
}
