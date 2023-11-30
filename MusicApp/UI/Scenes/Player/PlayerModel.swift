//
//  PlayerModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI
import MediaPlayer
import Combine

final class PlayerModel: ObservableObject {
    
    static var audioPlayer: MPMusicPlayerController? = MPMusicPlayerController.applicationQueuePlayer
    static var playerType: PlayerType = .audio
    
    @Published var expand: Bool = false
    @Published var hasRecentMedia: Bool = false
    @Published var showPlayerView: Bool = false
    
    // MARK: - Audio Player Properties
    
    @Published var playbackState: MPMusicPlaybackState? = audioPlayer?.playbackState
    var nowPlayingItem: Media?
    var playerOption: PlayerOption = PlayerOption()
    var progressRate: Int = 0
    private var recentMediaCancellable: AnyCancellable?
    
    var isPlaying: Bool {
        playbackState == .playing
    }
    
    // MARK: - Video Player Properties
    
    static var videoPlayer: VideoPlayerView = VideoPlayerView(videoAssetUrl: URL(string: "https://www.apple.com/404")!)
    var videoMedia: Bool = false
    
    init() {
        initPlayerFromUserDefaults()
        setupHasRecentMediaListener()
    }
    
    deinit {
        recentMediaCancellable?.cancel()
    }
    
    // MARK: - Public Methods
    
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
    
    func isNowPlaying(media: Media) -> Bool {
        return (media.trackName == nowPlayingItem?.trackName &&
                media.collectionName == nowPlayingItem?.collectionName &&
                media.artistName == nowPlayingItem?.artistName)
    }
    
    func playVideo(with videoAssetUrl: URL) {
        showPlayerView = true
        PlayerModel.playerType = .video
        
        DispatchQueue.global().async {
            PlayerModel.audioPlayer?.stop()
            PlayerModel.audioPlayer?.nowPlayingItem = nil
            PlayerModel.audioPlayer = nil
            PlayerModel.videoPlayer.player.replaceCurrentItem(with: AVPlayerItem(asset: AVAsset(url: videoAssetUrl)))
            
            DispatchQueue.main.async {
                withAnimation {
                    self.expand = true
                }
                self.nowPlayingItem = nil
            }
        }
    }
    
    func play(_ media: Media, videoAssetUrl: URL? = nil) {
        if media.mediaType != .musicVideo {
            setupAudioPlayer()
            PlayerModel.setShuffleMode(false)
            UserDefaults.standard.set([media.id], forKey: UserDefaultsKey.queueDefault)
            
            DispatchQueue.global().async {
                PlayerModel.audioPlayer?.setQueue(with: [media.id])
                PlayerModel.audioPlayer?.prepareToPlay()
                PlayerModel.audioPlayer?.play()
                
                DispatchQueue.main.async {
                    self.setNowPlayingMedia()
                }
            }
        } else {
            playVideo(with: videoAssetUrl ?? URL(string: "https://www.apple.com/404")!)
        }
    }
    
    func play(_ media: MPMediaItem, with query: [String]) {
        setupAudioPlayer()
        PlayerModel.setShuffleMode(false)
        UserDefaults.standard.set(query, forKey: UserDefaultsKey.queueDefault)
        
        DispatchQueue.global().async {
            PlayerModel.audioPlayer?.setQueue(with: query)
            PlayerModel.audioPlayer?.prepareToPlay()
            PlayerModel.audioPlayer?.play()
            PlayerModel.audioPlayer?.nowPlayingItem = media
            
            DispatchQueue.main.async {
                self.setNowPlayingMedia()
            }
        }
    }
    
    func playAllTracks(_ queue: [String], isShuffle: Bool = false) {
        setupAudioPlayer()
        UserDefaults.standard.set(queue, forKey: UserDefaultsKey.queueDefault)
        PlayerModel.setShuffleMode(isShuffle)
        
        DispatchQueue.global().async {
            PlayerModel.audioPlayer?.setQueue(with: queue)
            PlayerModel.audioPlayer?.play()
            
            DispatchQueue.main.async {
                self.setNowPlayingMedia()
            }
        }
    }
    
    func skipToNextItem() {
        DispatchQueue.global().async {
            PlayerModel.audioPlayer?.skipToNextItem()
            
            DispatchQueue.main.async {
                self.setNowPlayingMedia()
            }
        }
    }
        
    func skipToPreviousItem() {
        DispatchQueue.global().async {
            PlayerModel.audioPlayer?.skipToPreviousItem()
            
            DispatchQueue.main.async {
                self.setNowPlayingMedia()
            }
        }
    }
}

// MARK: - Private Methods

private extension PlayerModel {
    
    func initPlayerFromUserDefaults() {
        switch (UserDefaults.standard.integer(forKey: UserDefaultsKey.repeatDefault)) {
            case 0:
                PlayerModel.audioPlayer?.repeatMode = .none
                playerOption.repeatMode = .noRepeat
            case 1:
                PlayerModel.audioPlayer?.repeatMode = .all
                playerOption.repeatMode = .albumRepeat
            case 2:
                PlayerModel.audioPlayer?.repeatMode = .one
                playerOption.repeatMode = .oneSongRepeat
            default:
                PlayerModel.audioPlayer?.repeatMode = .none
                playerOption.repeatMode = .noRepeat
        }
        
        if let recentMedia = UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) as? [String] {
            DispatchQueue.global(qos: .background).async {
                PlayerModel.audioPlayer?.setQueue(with: recentMedia)
                PlayerModel.audioPlayer?.prepareToPlay()
                PlayerModel.audioPlayer?.skipToBeginning()
                
                DispatchQueue.main.async {
                    self.setNowPlayingMedia()
                }
            }
        }
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.shuffleDefault) {
            PlayerModel.audioPlayer?.shuffleMode = MPMusicShuffleMode.songs
        }
    }

func setupHasRecentMediaListener() {
    recentMediaCancellable = $hasRecentMedia.sink { [weak self] in
        guard let self = self else { return }
        if $0 || self.isPlaying && self.showPlayerView == false {
            DispatchQueue.main.async {
                self.showPlayerView = true
            }
        }
    }
}

func setNowPlayingMedia() {
    guard let media = PlayerModel.audioPlayer?.nowPlayingItem else { return }
    
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
    
    nowPlayingItem = Media(mediaResponse: MediaResponse(id: media.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: mediaKind.value, name: media.title, artistName: media.artist, collectionName: media.albumTitle, trackName: media.title, collectionCensoredName: media.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: media.assetURL?.absoluteString, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: media.isExplicitItem ? "explicit" : "notExplicit", discCount: 0, discNumber: nil, trackCount: media.albumTrackCount, trackNumber: media.albumTrackNumber, trackTimeMillis: media.playbackDuration, country: nil, currency: nil, primaryGenreName: media.genre, description: nil, longDescription: nil, releaseDate: media.releaseDate?.ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 0, artwork: media.artwork?.image(at: CGSize(width: 1024, height: 1024)), composer: media.composer, isCompilation: media.isCompilation))
    
    if PlayerModel.playerType == .video {
        PlayerModel.playerType = .audio
        PlayerModel.videoPlayer.toggleIsPlaying()
    }
    hasRecentMedia = true
}

func setupAudioPlayer() {
    PlayerModel.playerType = .audio
    if PlayerModel.audioPlayer == nil, PlayerModel.playerType == .audio {
        PlayerModel.audioPlayer = MPMusicPlayerController.applicationQueuePlayer
    }
}

static func setShuffleMode(_ value: Bool) {
    UserDefaults.standard.set(value, forKey: UserDefaultsKey.shuffleDefault)
    PlayerModel.audioPlayer?.shuffleMode = value ? MPMusicShuffleMode.songs : MPMusicShuffleMode.off
}
}

// MARK: - Types

extension PlayerModel {
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

enum PlayerType {
    case video
    case audio
}
