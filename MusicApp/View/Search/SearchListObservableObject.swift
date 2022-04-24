//
//  SearchListObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import MediaPlayer

final class SearchListObservableObject: ObservableObject {
    private var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    
    @Published var media: Media?
    @Published private(set) var artistContents: ArtistContents?
    @Published private var songIDsQueue: [String] = []
    @Published private(set) var waitingForPrepare: Bool = false
    
    
    private func initSongsInAlbum() {
        guard let artistName = media?.artistName else { return }
        setSongsFor(artistName: artistName)
    }

    private func setIDsQueue() {
        var stringQueue: [String] = []
        songIDsQueue.removeAll()
        artistContents?.songs.forEach({ song in
            stringQueue.append(song.playbackStoreID)
        })
        
        songIDsQueue = stringQueue
    }
    
    private func setSongsFor(artistName: String) {
        artistContents = ArtistContents(songs: getSongsFor(Artist: artistName))
    }
    
    private func getSongsFor(Artist: String) -> [MPMediaItem] {
        let albumTitleFilter = MPMediaPropertyPredicate(value: Artist,
                                                        forProperty: MPMediaItemPropertyArtist,
                                                        comparisonType: .equalTo)
        
        if let collections = MPMediaQuery(filterPredicates: Set(arrayLiteral: albumTitleFilter)).items {
            return collections
        } else {
            return []
        }
    }
    
    func getSongsCount() -> Int {
        return artistContents?.songs.count ?? 0
    }
    
    func playSongAt(songIndex: Int) {
        initSongsInAlbum()
        setIDsQueue()
        waitingForPrepare = true
        player.stop()
        player.prepareToPlay()
        player.setQueue(with: songIDsQueue)
        UserDefaults.standard.set(songIDsQueue, forKey: UserDefaultsKey.queueDefault)

        player.nowPlayingItem = artistContents?.songs[0]
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
        player.shuffleMode = MPMusicShuffleMode.off
        
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.waitingForPrepare = false
        }
    }
}
struct ArtistContents {
    var songs: [MPMediaItem] = []
}
