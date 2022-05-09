//
//  PlayerObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI
import MediaPlayer

enum RepeatMode: CaseIterable {
    case noRepeat
    case albumRepeat
    case oneSongRepeat
}

struct PlayerOption {
    var repeatMode: RepeatMode = .noRepeat
    var isShuffle: Bool = false
}

enum UserDefaultsKey {
    static let repeatDefault = "repeatDefault"
    static let queueDefault = "queueDefault"
    static let shuffleDefault = "shuffleDefault"
    static let libraryListSelection = "libraryListSelection"
    static let orderedLibraryList = "orderedLibraryList"
}

final class PlayerObservableObject: ObservableObject {
    var player: MPMusicPlayerController
    @Published var nowPlayingItem: Media?
    @Published var playbackState: MPMusicPlaybackState? = MPMusicPlayerController.applicationMusicPlayer.playbackState
    @Published var playerOption = PlayerOption()
    @Published var progressRate: Int = 0
    
    let noTrackTime = 100.0
    
    init(player: MPMusicPlayerController) {
        self.player = player
    }
    
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
        if (UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) != nil) {
            player.setQueue(with: UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) as? [String] ?? [String]())
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
            nowPlayingItem?.trackName = "Not Playing"
            nowPlayingItem?.artwork = nil
            nowPlayingItem?.artistName = nil
            nowPlayingItem?.trackTimeMillis = 0
            
            return
        }
        var image: UIImage? = nil
        if let artwork = media.artwork?.image(at: CGSize(width: 1024, height: 1024)) {
            image = artwork
        }
        
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
        
        nowPlayingItem = Media(kind: kind, artistName: media.artist, collectionName: media.albumTitle, trackName: media.title, trackTimeMillis: media.playbackDuration, description: media.description, artwork: image == nil ? nil : Image(uiImage: image ?? UIImage()), artworkUIImage: image, releaseDate: media.releaseDate)
    }
}
