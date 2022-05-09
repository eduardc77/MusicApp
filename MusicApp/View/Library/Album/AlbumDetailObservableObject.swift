//
//  AlbumDetailObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer

final class AlbumDetailObservableObject: ObservableObject {
    @Published private var trackIDsQueue: [String] = []
    @Published private(set) var albumContents: AlbumContents?
    @Published private(set) var waitingForPrepare: Bool = false
    
    private(set) var player = MPMusicPlayerController.applicationMusicPlayer
    private(set) var media: Media
    private(set) var albumDuration: Int = 0
    private(set) var albumTrackCount: Int = 0
    
    var trackCount: Int {
        albumContents?.tracks.count ?? 0
    }
    
    // MARK: - Initialization
    
    init(media: Media) {
        self.media = media
        
        setAlbumContents()
        configureAlbumDetails()
    }
    
    // MARK: - Public Methods
    
    func playTrack(at index: Int) {
        waitingForPrepare = true
        player.stop()
        
        player.setQueue(with: trackIDsQueue)
        UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
        
        player.shuffleMode = MPMusicShuffleMode.off
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
        
        player.play()
        player.nowPlayingItem = albumContents?.tracks[index]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.waitingForPrepare = false
        }
    }
    
    func playAllTracks(isShuffle: Bool) {
        waitingForPrepare = true
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.waitingForPrepare = false
        }
    }
    
    func mediaItem(with persistentId: String) -> MPMediaItem? {
            let songQuery = MPMediaQuery.songs()

            songQuery.addFilterPredicate(MPMediaPropertyPredicate(value: persistentId,
                                                                  forProperty: MPMediaItemPropertyPersistentID,
                                                                  comparisonType: .equalTo))
            
            return songQuery.items?.first
        }
}

// MARK: - Private Methods

private extension AlbumDetailObservableObject {
    func setAlbumContents() {
        albumContents = AlbumContents(tracks: getTracks(for: media.collectionName ?? ""))
    }
    
    func configureAlbumDetails() {
        var albumDuration: TimeInterval = 0
        
        trackIDsQueue.removeAll()
        albumContents?.tracks.forEach { track in
            trackIDsQueue.append(track.playbackStoreID)
            albumDuration += track.playbackDuration
            albumTrackCount += 1
        }
        
        self.albumDuration = Int((albumDuration / 60).truncatingRemainder(dividingBy: 60))
    }
    
    func getTracks(for album: String) -> [MPMediaItem] {
        let albumTitleFilter = MPMediaPropertyPredicate(value: album,
                                                        forProperty: MPMediaItemPropertyAlbumTitle,
                                                        comparisonType: .equalTo)
        
        if let collections = MPMediaQuery(filterPredicates: Set(arrayLiteral: albumTitleFilter)).items {
            return collections
        } else {
            return []
        }
    }
}


// MARK: - Types

extension AlbumDetailObservableObject {
    struct AlbumContents {
        var tracks: [MPMediaItem] = []
    }
}
