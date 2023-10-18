//
//  LibraryViewModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer
import SwiftUI

final class LibraryModel: ObservableObject {
   
   // MARK: - Types
   
   enum AuthorizationStatus {
      case notYetDetermined
      case permitted
      case notPermitted
   }
   
   // MARK: - Properties
   
   @Published private(set) var status: AuthorizationStatus = .notYetDetermined
   @Published private(set) var loadingLibrary: Bool = false
   private(set) var propertyListEncoder = PropertyListEncoder()
   private(set) var propertyListDecoder = PropertyListDecoder()
   
   // Library Contents
   var libraryContent = [LibrarySection: [Media]]()
   var recentlyAdded = [Media]()
   
   var emptyLibrary: Bool {
      libraryContent.isEmpty
   }
   
   // MARK: - Initialization
   
   init() {
      checkForLibraryAuthorization()
   }
   
   // MARK: - Public Methods
   
   func loadLibraryContent() {
      guard status == .permitted else { return }
      
      loadingLibrary = true
      DispatchQueue.main.async {
         LibrarySection.allCases.forEach { section in
            self.loadLibrary(for: .albums)
         }
         self.loadingLibrary = false
      }
   }
   
   func loadLibrary(for librarySection: LibrarySection, recentlyAddedOnly: Bool = false) {
      guard status == .permitted else { return }
      
      loadingLibrary = true
      DispatchQueue.main.async {
         self.libraryContent[librarySection] = self.loadMedia(forSection: librarySection, recentlyAddedOnly: recentlyAddedOnly)
         self.loadingLibrary = false
      }
   }
}

// MARK: - Private Methods

private extension LibraryModel {
   
   func checkForLibraryAuthorization() {
      switch MPMediaLibrary.authorizationStatus() {
         case .authorized:
            status = .permitted
            loadLibrary(for: .albums, recentlyAddedOnly: true)
         case .notDetermined:
            MPMediaLibrary.requestAuthorization() { status in
               DispatchQueue.main.async {
                  if status == .authorized {
                     self.status = .permitted
                     self.loadLibrary(for: .albums, recentlyAddedOnly: true)
                  } else {
                     self.status = .notPermitted
                  }
               }
            }
         default:
            status = .notPermitted
      }
   }
   
   func loadMedia(forSection librarySection: LibrarySection, recentlyAddedOnly: Bool = false) -> [Media] {
      let collections: [MPMediaItemCollection]?
      
      switch librarySection {
         case .playlists: collections = MPMediaQuery.playlists().collections
         case .artists: collections = MPMediaQuery.artists().collections
         case .albums: collections = MPMediaQuery.albums().collections
         case .songs: collections = MPMediaQuery.songs().collections
         case .musicVideos: collections = MPMediaQuery.playlists().collections
         case .genres: collections = MPMediaQuery.genres().collections
         case .compilations: collections = MPMediaQuery.compilations().collections
         case .composers: collections = MPMediaQuery.composers().collections
         default: collections = nil
      }
      var mediaList = [Media]()
      
      if let collections = collections {
         collections.forEach { libraryMediaItemCollection in
            guard let libraryMedia = libraryMediaItemCollection.representativeItem else { return }
            
            let mediaKind: MediaKind
            
            switch libraryMedia.mediaType {
               case .music: mediaKind = .song
               case .podcast: mediaKind = .podcastEpisode
               case .audioBook: mediaKind = .ebook
               case .anyAudio: mediaKind = .song
               case .movie: mediaKind = .featureMovie
               case .videoPodcast: mediaKind = .podcastEpisode
               case .tvShow: mediaKind = .tvEpisode
               case .musicVideo: mediaKind = .musicVideo
               case .anyAudio: mediaKind = .song
               case .audioITunesU: mediaKind = .song
               case .videoITunesU: mediaKind = .musicVideo
               case .homeVideo: mediaKind = .musicVideo
               case .anyVideo: mediaKind = .musicVideo
               case .any: mediaKind = .song
               default: mediaKind = .song
            }
            let wrapperType: WrapperType
            
            switch librarySection {
               case .artists: wrapperType = .artist
               case .songs: wrapperType = .track
               default: wrapperType = .collection
            }
            
            let newLibraryMedia = Media(mediaResponse: MediaResponse(id: libraryMedia.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: wrapperType.rawValue, kind: mediaKind.value, name: libraryMedia.title, artistName: libraryMedia.albumArtist, collectionName: libraryMedia.albumTitle, trackName: libraryMedia.title, collectionCensoredName: libraryMedia.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: libraryMedia.isExplicitItem ? "explicit" : "notExplicit", discCount: 0, discNumber: nil, trackCount: libraryMedia.albumTrackCount, trackNumber: libraryMedia.albumTrackNumber, trackTimeMillis: libraryMedia.playbackDuration, country: nil, currency: nil, primaryGenreName: libraryMedia.genre, description: nil, longDescription: nil, releaseDate: libraryMedia.releaseDate?.ISO8601Format().description, contentAdvisoryRating: nil, trackRentalPrice: 0, artwork: libraryMedia.artwork?.image(at: CGSize(width: 1024, height: 1024)), composer: libraryMedia.composer, isCompilation: libraryMedia.isCompilation, dateAdded: libraryMedia.dateAdded))
            
            // Set Recently Added Albums
            if recentlyAddedOnly {
               if librarySection == .albums, let oneYearBefore = Calendar.current.date(byAdding: .year, value: -2, to: Date()), libraryMedia.dateAdded >= oneYearBefore {
                  recentlyAdded.append(newLibraryMedia)
               }
            } else {
               // Add New Library Media
               mediaList.append(newLibraryMedia)
            }
         }
      }
      return mediaList
   }
}
