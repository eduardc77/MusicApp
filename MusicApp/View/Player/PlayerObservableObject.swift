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
}

final class PlayerObservableObject: ObservableObject {
    var player: MPMusicPlayerController
    @Published private(set) var nowPlayingItem: Media?
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
            nowPlayingItem?.trackName = "Cold Heart"
            nowPlayingItem?.artworkUrl100 = URL(fileURLWithPath: (Bundle.main.resourcePath ?? "") + "/elton")
            nowPlayingItem?.artistName = "Elton John"
            nowPlayingItem?.trackTimeMillis = 215
            
            return
        }
        nowPlayingItem = Media(id: media.playbackStoreID, trackName: media.title, artistName: media.artist, description: media.description, kind: MediaKind(rawValue: "\(media.mediaType)"), artwork: media.artwork?.image(at: CGSize(width: 600, height: 600)), collectionName: media.albumTitle, trackTimeMillis: media.playbackDuration, releaseDate: media.releaseDate)
        
        nowPlayingItem?.trackName = media.title ?? ""
        nowPlayingItem?.artworkUrl100 = media.assetURL ?? URL(fileURLWithPath: "")
        nowPlayingItem?.artistName = media.artist ?? ""
        nowPlayingItem?.trackTimeMillis = player.nowPlayingItem?.playbackDuration ?? noTrackTime
    }
}
