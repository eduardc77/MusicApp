//
//  AlbumDetailObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer

struct AlbumContents {
    var songs: [MPMediaItem] = []
}

final class AlbumDetailObservableObject: ObservableObject {
    private var player = MPMusicPlayerController.applicationMusicPlayer
    private(set) var media: Media
    @Published private(set) var albumContents: AlbumContents?
    @Published private var songIDsQueue: [String] = []
    @Published private(set) var waitingForPrepare: Bool = false
    
    init(media: Media) {
        self.media = media
        
        initSongsInAlbum()
        setIDsQueue()
    }
    
    var albumDuration: Int {
        var albumDuration: TimeInterval = 0
        albumContents?.songs.forEach { song in
            albumDuration += song.playbackDuration
        }
        
        return Int((albumDuration / 60).truncatingRemainder(dividingBy: 60))
    }
    
    var albumTrackCount: Int {
        var albumTrackCount: Int = 0
        albumContents?.songs.forEach { song in
            albumTrackCount += 1
        }
        
        return albumTrackCount
    }
    
    private func initSongsInAlbum() {
        setSongsInAlbumDetail(albumTitle: media.collectionName ?? "")
    }

    private func setIDsQueue() {
        var stringQueue: [String] = []
        songIDsQueue.removeAll()
        albumContents?.songs.forEach { song in
            stringQueue.append(song.playbackStoreID)
        }
        
        songIDsQueue = stringQueue
    }
    
    private func setSongsInAlbumDetail(albumTitle: String) {
        albumContents = AlbumContents(songs: getSongsFor(Album: albumTitle))
    }
    
    private func getSongsFor(Album: String) -> [MPMediaItem] {
        let albumTitleFilter = MPMediaPropertyPredicate(value: Album,
                                                        forProperty: MPMediaItemPropertyAlbumTitle,
                                                        comparisonType: .equalTo)
        
        if let collections = MPMediaQuery(filterPredicates: Set(arrayLiteral: albumTitleFilter)).items {
            return collections
        } else {
            return []
        }
    }
    
    func getSongsCount() -> Int {
        return albumContents?.songs.count ?? 0
    }
    
    func allSongsPlayButtonPressed(isShuffle: Bool) {
        waitingForPrepare = true
        player.stop()
        player.setQueue(with: songIDsQueue)
        UserDefaults.standard.set(songIDsQueue, forKey: UserDefaultsKey.queueDefault)
        if isShuffle {
            player.shuffleMode = MPMusicShuffleMode.songs
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.shuffleDefault)
            player.shuffleMode = MPMusicShuffleMode.songs
        } else {
            UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
            player.shuffleMode = MPMusicShuffleMode.off
        }
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.waitingForPrepare = false
        }
    }
    
    func specificSongPlayButtonPressed(songIndex: Int) {
        waitingForPrepare = true
        player.stop()
        player.setQueue(with: songIDsQueue)
        UserDefaults.standard.set(songIDsQueue, forKey: UserDefaultsKey.queueDefault)
        player.play()
        player.nowPlayingItem = albumContents?.songs[songIndex]
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
        player.shuffleMode = MPMusicShuffleMode.off
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.waitingForPrepare = false
        }
    }
}

