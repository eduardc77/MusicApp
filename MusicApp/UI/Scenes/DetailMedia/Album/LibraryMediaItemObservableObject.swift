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
   @Published private(set) var libraryTracks: [MPMediaItem] = []
   
   // MARK: - Properties
   
   private(set) var media: Media
   private(set) var albumDuration: Int = 0
   
   var trackCount: Int {
      guard !libraryTracks.isEmpty else { return 0 }
      return libraryTracks.count
   }
   
   // MARK: - Initialization
   
   init(media: Media) {
      self.media = media
      
      setAlbumContents()
      
      if !libraryTracks.isEmpty {
         configureAlbumDetailsForLibraryAlbum()
      }
   }
   
   deinit {
      print("deinit LibraryMediaItemObservableObject")
   }
   
   // MARK: - Public Methods
   
   @MainActor
   func playTrack(at index: Int) {
      PlayerObservableObject.playerType = .audio
      PlayerObservableObject.audioPlayer.stop()
      PlayerObservableObject.audioPlayer.setQueue(with: trackIDsQueue)
      UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
      PlayerObservableObject.audioPlayer.play()
      PlayerObservableObject.setShuffleMode(false)
      PlayerObservableObject.audioPlayer.nowPlayingItem = libraryTracks[index]
   }
   
   @MainActor
   func playAllTracks(isShuffle: Bool) {
      PlayerObservableObject.playerType = .audio
      PlayerObservableObject.audioPlayer.stop()
      PlayerObservableObject.audioPlayer.setQueue(with: trackIDsQueue)
      UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
      PlayerObservableObject.setShuffleMode(isShuffle)
      PlayerObservableObject.audioPlayer.play()
   }
   
   func currentMediaItem() -> MPMediaItem? {
      let mediaItemQuery = MPMediaQuery.songs()
      mediaItemQuery.addFilterPredicate(MPMediaPropertyPredicate(value: media.id,
                                                                 forProperty: MPMediaItemPropertyPersistentID,
                                                                 comparisonType: MPMediaPredicateComparison.equalTo))
      if let mediaItem = mediaItemQuery.items?.first {
         return mediaItem
      } else {
         
         mediaItemQuery.addFilterPredicate(MPMediaPropertyPredicate(value: media.name,
                                                                    forProperty: MPMediaItemPropertyTitle,
                                                                    comparisonType: MPMediaPredicateComparison.contains))
         if let mediaItem = mediaItemQuery.items?.first {
            return mediaItem
         }
      }
      return nil
   }
   
   func trackNumber(at index: Int) -> Int {
      return libraryTracks[index].albumTrackNumber
   }
   
   func trackTitle(at index: Int) -> String {
      return libraryTracks[index].title ?? ""
   }
   
   func trackExplicitness(at index: Int) -> Bool {
      if !libraryTracks.isEmpty {
         return libraryTracks[index].isExplicitItem
      } else {
         return false
      }
   }
}

// MARK: - Private Methods

private extension LibraryMediaItemObservableObject {
   func setAlbumContents() {
      if let libraryTracks = getTracks(for: media.collectionName), !libraryTracks.isEmpty {
         self.libraryTracks = libraryTracks
      } else {
         //                 searchTracksForCurrentMedia()
         //                self.albumContents = AlbumContents(tracks: self.searchObservableObject.collectionContentResults)
      }
   }
   
   func configureAlbumDetailsForLibraryAlbum() {
      var albumDuration: TimeInterval = 0
      trackIDsQueue.removeAll()
      libraryTracks.forEach { track in
         trackIDsQueue.append(track.playbackStoreID)
         albumDuration += track.playbackDuration
      }
      self.albumDuration = (albumDuration / 60).rounded(.up).toInt
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
