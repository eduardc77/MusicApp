//
//  LibraryMediaItemObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 08.05.2022.
//

import MediaPlayer
import SwiftUI

final class LibraryMediaItemObservableObject: ObservableObject {
    // MARK: - Publishers
    
    @Published private var trackIDsQueue: [String] = []
    @Published private(set) var albumContents: AlbumContents?
    @Published private(set) var waitingForPrepare: Bool = false
    
    // MARK: - Properties
    
    private(set) var player = MPMusicPlayerController.applicationMusicPlayer
    private(set) var media: Media
    private(set) var albumDuration: Int = 0
    private(set) var albumTrackCount: Int = 0
    
    @ObservedObject var searchObservableObject: SearchObservableObject
    
    var trackCount: Int {
        if let libraryAlbumTracks = albumContents?.libraryTracks, !libraryAlbumTracks.isEmpty {
            return libraryAlbumTracks.count
        } else {
            return albumContents?.tracks.count ?? 0
        }
    }
    
    // MARK: - Initialization
    
    init(media: Media, searchObservableObject: SearchObservableObject) {
        self.media = media
        self.searchObservableObject = searchObservableObject
        
        setAlbumContents()
        
        if let libraryAlbumTracks = albumContents?.libraryTracks, !libraryAlbumTracks.isEmpty {
            configureAlbumDetailsForLibraryAlbum()
        }
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
        if let libraryAlbumTracks = albumContents?.libraryTracks, !libraryAlbumTracks.isEmpty {
            player.nowPlayingItem = albumContents?.libraryTracks[index]
        }
        
        
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
    
    func currentMediaItem() -> MPMediaItem? {
        let mediaItemQuery = MPMediaQuery.songs()
        mediaItemQuery.addFilterPredicate(MPMediaPropertyPredicate(value: media.id,
                                                                   forProperty: MPMediaItemPropertyPersistentID,
                                                                   comparisonType: MPMediaPredicateComparison.equalTo))
        if let mediaItem = mediaItemQuery.items?.first {
            return mediaItem
        } else {
            
            mediaItemQuery.addFilterPredicate(MPMediaPropertyPredicate(value: media.trackName,
                                                                       forProperty: MPMediaItemPropertyTitle,
                                                                       comparisonType: MPMediaPredicateComparison.contains))
            
            if let mediaItem = mediaItemQuery.items?.first {
                return mediaItem
            }
        }
        
        return nil
    }
    
    func trackNumber(at index: Int) -> Int {
        if let libraryAlbumTracks = albumContents?.libraryTracks, !libraryAlbumTracks.isEmpty {
            return libraryAlbumTracks[index].albumTrackNumber
        } else if let trackNumber = albumContents?.tracks[index].trackNumber {
            return Int(trackNumber) ?? 0
        } else {
            return 0
        }
    }
    
    func trackTitle(at index: Int) -> String {
        if let libraryAlbumTracks = albumContents?.libraryTracks, !libraryAlbumTracks.isEmpty {
            return libraryAlbumTracks[index].title ?? ""
        } else {
            return albumContents?.tracks[index].trackName ?? ""
        }
    }
}

// MARK: - Private Methods

private extension LibraryMediaItemObservableObject {
    func setAlbumContents() {
        if let libraryAlbums = getTracks(for: media.collectionName), !libraryAlbums.isEmpty {
            albumContents = AlbumContents(libraryTracks: libraryAlbums)
        } else {
            //                 searchTracksForCurrentMedia()
            //                self.albumContents = AlbumContents(tracks: self.searchObservableObject.collectionContentResults)
        }
    }
    
    func configureAlbumDetailsForLibraryAlbum() {
        var albumDuration: TimeInterval = 0
        
        trackIDsQueue.removeAll()
        albumContents?.libraryTracks.forEach { track in
            trackIDsQueue.append(track.playbackStoreID)
            albumDuration += track.playbackDuration
            albumTrackCount += 1
        }
        
        self.albumDuration = Int((albumDuration / 60).truncatingRemainder(dividingBy: 60))
    }
    
    func getTracks(for album: String) -> [MPMediaItem]? {
        let albumTitleFilter = MPMediaPropertyPredicate(value: album,
                                                        forProperty: MPMediaItemPropertyAlbumTitle,
                                                        comparisonType: .equalTo)
        
        if let collections = MPMediaQuery(filterPredicates: Set(arrayLiteral: albumTitleFilter)).items, !collections.isEmpty {
            return collections
        } else {
            return nil
        }
    }
    
    func searchTracksForCurrentMedia() {
        //     searchObservableObject.lookUpAlbum(for: media)
    }
}

// MARK: - Types

extension LibraryMediaItemObservableObject {
    struct AlbumContents {
        var libraryTracks: [MPMediaItem] = []
        var tracks: [Media] = []
    }
}
