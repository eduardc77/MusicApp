//
//  PlayerObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI
import MediaPlayer

final class PlayerObservableObject: ObservableObject {
    // MARK: - Properties
    
    let player = MPMusicPlayerController.applicationMusicPlayer
    let noTrackTime = 100.0
    
    // MARK: - Publishers
    
    @Published var nowPlayingItem: Media?
    @Published var playbackState: MPMusicPlaybackState? = MPMusicPlayerController.applicationMusicPlayer.playbackState
    @Published var playerOption = PlayerOption()
    @Published var progressRate: Int = 0

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
//        var image: UIImage? = nil
//        if let artwork = media.artwork?.image(at: CGSize(width: 1024, height: 1024)) {
//            image = artwork
//        }
        
        let kind: MediaKind
        
        switch media.mediaType.rawValue {
        case 1: kind = MediaKind.song
        case 2: kind = MediaKind.podcast
        case 4: kind = MediaKind.audiobook
        case 255: kind = MediaKind.song
        case 256: kind = MediaKind.movie
        case 512: kind = MediaKind.tvSeason
        case 1024: kind = MediaKind.mix
        case 2048: kind = MediaKind.musicVideo
        case 4096: kind = MediaKind.musicVideo
        case 65280: kind = MediaKind.musicVideo
        default: kind = MediaKind.playlist
        }
        
        nowPlayingItem = Media(mediaResponse: MediaResponse(id: media.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: kind.rawValue, name: media.title, artistName: media.artist, collectionName: media.albumTitle, trackName: media.title, collectionCensoredName: media.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl60: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: nil, discCount: 0, discNumber: nil, trackCount: media.albumTrackCount, trackNumber: media.albumTrackNumber, trackTimeMillis: media.playbackDuration.toInt, country: nil, currency: nil, primaryGenreName: media.genre, description: nil, longDescription: nil, releaseDate: media.releaseDate?.description, contentAdvisoryRating: nil, trackRentalPrice: 0))
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
