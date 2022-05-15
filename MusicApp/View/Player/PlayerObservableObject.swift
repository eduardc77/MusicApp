//
//  PlayerObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI
import MediaPlayer

enum PlayerType {
    case video
    case audio
}

final class PlayerObservableObject: ObservableObject {
    @Published var expand: Bool = false
    var playerType: PlayerType = .audio
    
    // MARK: - Audio Player Properties
    
    @Published var nowPlayingItem: Media?
    @Published var playbackState: MPMusicPlaybackState? = MPMusicPlayerController.applicationMusicPlayer.playbackState
    @Published var playerOption = PlayerOption()
    @Published var progressRate: Int = 0
    
    let player = MPMusicPlayerController.applicationMusicPlayer
    let noTrackTime = 100
    
    // MARK: - Video Player Properties
    
    var videoPlayer: VideoPlayerView = VideoPlayerView(url: URL(string: "https://www.apple.com/404")!)
    
    // MARK: - Public Methods
    
    func initPlayerFromUserDefaults() {
        switch (UserDefaults.standard.integer(forKey: UserDefaultsKey.repeatDefault)) {
        case 0:
            player.repeatMode = .none
            playerOption.repeatMode = .noRepeat
        case 1:
            player.repeatMode = .all
            playerOption.repeatMode = .albumRepeat
        case 2:
            player.repeatMode = .one
            playerOption.repeatMode = .oneSongRepeat
        default:
            player.repeatMode = .none
            playerOption.repeatMode = .noRepeat
        }
        if let recentTrack = UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) as? [String] {
            player.setQueue(with: recentTrack)
            player.prepareToPlay()
            player.skipToBeginning()
        }
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.shuffleDefault) {
            player.shuffleMode = MPMusicShuffleMode.songs
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
    
    func makeNowPlaying(media: MPMediaItem? = nil) {
        guard let media = media else {
            nowPlayingItem = nil
            
            return
        }
        
        let kind: MediaKind
        
        switch media.mediaType {
        case .music: kind = MediaKind.song
        case .podcast: kind = MediaKind.podcast
        case .audioBook: kind = MediaKind.audiobook
        case .anyAudio: kind = MediaKind.song
        case .movie: kind = MediaKind.movie
        case .tvShow: kind = MediaKind.tvSeason
        case .musicVideo: kind = MediaKind.musicVideo
        case .movie: kind = MediaKind.movie
        case .anyVideo: kind = MediaKind.musicVideo
        case .any: kind = MediaKind.mix
        default: kind = MediaKind.album
        }
        
        nowPlayingItem = Media(mediaResponse: MediaResponse(id: media.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: kind.rawValue, name: media.title, artistName: media.artist, collectionName: media.albumTitle, trackName: media.title, collectionCensoredName: media.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: nil, discCount: 0, discNumber: nil, trackCount: media.albumTrackCount, trackNumber: media.albumTrackNumber, trackTimeMillis: media.playbackDuration.toInt, country: nil, currency: nil, primaryGenreName: media.genre, description: nil, longDescription: nil, releaseDate: media.releaseDate?.description, contentAdvisoryRating: nil, trackRentalPrice: 0, artwork: media.artwork?.image(at: CGSize(width: 1024, height: 1024)), composer: media.composer, isCompilation: media.isCompilation))
    }
    
    func configureVideoPlayer(with videoMediaUrl: URL) {
        nowPlayingItem = nil
        videoPlayer.isPlaying
        playerType = .video
        videoPlayer = VideoPlayerView(url: videoMediaUrl)
        expand = true
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
