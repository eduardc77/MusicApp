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
	@Published private(set) var albumContents: AlbumContents = AlbumContents()
	
	// MARK: - Properties
	
	private(set) var player = MPMusicPlayerController.applicationMusicPlayer
	private(set) var media: Media
	private(set) var albumDuration: Int = 0
	private(set) var albumTrackCount: Int = 0
	
	@ObservedObject var searchObservableObject: SearchObservableObject
	
	var trackCount: Int {
		guard !albumContents.libraryTracks.isEmpty else { return 0 }
		
		return albumContents.libraryTracks.count
	}
	
	// MARK: - Initialization
	
	init(media: Media, searchObservableObject: SearchObservableObject) {
		self.media = media
		self.searchObservableObject = searchObservableObject
		
		setAlbumContents()
		
		if !albumContents.libraryTracks.isEmpty {
			configureAlbumDetailsForLibraryAlbum()
		}
	}
	
	// MARK: - Public Methods
	
	func playTrack(at index: Int) {
		player.stop()
		player.setQueue(with: trackIDsQueue)
		UserDefaults.standard.set(trackIDsQueue, forKey: UserDefaultsKey.queueDefault)
		player.play()
		player.nowPlayingItem = albumContents.libraryTracks[index]
		UserDefaults.standard.set(false, forKey: UserDefaultsKey.shuffleDefault)
		player.shuffleMode = MPMusicShuffleMode.off
	}
	
	func playAllTracks(isShuffle: Bool) {
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
		return albumContents.libraryTracks[index].albumTrackNumber
	}
	
	func trackTitle(at index: Int) -> String {
		return albumContents.libraryTracks[index].title ?? ""
	}
	
	func trackExplicitness(at index: Int) -> Bool {
		if !albumContents.libraryTracks.isEmpty {
			return albumContents.libraryTracks[index].isExplicitItem
		} else {
			return false
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
		albumContents.libraryTracks.forEach { track in
			trackIDsQueue.append(track.playbackStoreID)
			albumDuration += track.playbackDuration
			albumTrackCount += 1
		}
		self.albumDuration = Int((albumDuration / 60).rounded(.up))
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
	}
}
