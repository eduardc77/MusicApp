//
//  LibraryObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer
import SwiftUI

final class LibraryObservableObject: ObservableObject {
    @Published private(set) var status: AuthorizationStatus = .notYetDetermined
    @Published private(set) var refreshingLibrary: Bool = false
    @Published private(set) var refreshComplete: Bool = false
    
    // MARK: - Library Contents
    
    @Published private(set) var playlists = [Media]()
    @Published private(set) var artists = [Media]()
    @Published private(set) var albums = [Media]()
    @Published private(set) var songs = [Media]()
    @Published private(set) var madeForYou = [Media]()
    @Published private(set) var tvAndMovies = [Media]()
    @Published private(set) var musicVideos = [Media]()
    @Published private(set) var genres = [Media]()
    @Published private(set) var compilations = [Media]()
    @Published private(set) var composers = [Media]()
    @Published private(set) var downloaded = [Media]()
    @Published private(set) var homeSharing = [Media]()
    @Published private(set) var recentlyAdded = [Media]()
    
    // MARK: - Initialization
    
    init() {
        checkForLibraryAuthorization()
    }
    
    // MARK: - Public Methods
    
    func refreshAllLibrary() {
        guard  status == .permitted else { return }
        self.refreshingLibrary = true
        
        DispatchQueue.main.async {
            LibrarySection.allCases.forEach { section in
                self.refreshLibrary(for: section)
            }
            
            self.refreshingLibrary = false
            self.refreshComplete = true
        }
    }
    
    func refreshLibrary(for librarySection: LibrarySection) {
        switch librarySection {
        case .albums:
            albums = loadMedia(forSection: .albums)
        case .playlists:
            playlists = loadMedia(forSection: .playlists)
        case .artists:
            artists = loadMedia(forSection: .artists)
        case .songs:
            songs = loadMedia(forSection: .songs)
        case .madeForYou:
            madeForYou = loadMedia(forSection: .madeForYou)
        case .tvAndMovies:
            tvAndMovies = loadMedia(forSection: .tvAndMovies)
        case .musicVideos:
            musicVideos = loadMedia(forSection: .musicVideos)
        case .genres:
            genres = loadMedia(forSection: .genres)
        case .compilations:
            compilations = loadMedia(forSection: .compilations)
        case .composers:
            composers = loadMedia(forSection: .composers)
        case .downloaded:
            downloaded = loadMedia(forSection: .downloaded)
        case .homeSharing:
            homeSharing = loadMedia(forSection: .homeSharing)
        }
    }
}

// MARK: - Private Methods

private extension LibraryObservableObject {
    func checkForLibraryAuthorization()  {
        let status = MPMediaLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            self.status = .permitted
        case .notDetermined:
            MPMediaLibrary.requestAuthorization() { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.status = .permitted
                    } else {
                        self.status = .notPermitted
                    }
                }
            }
        default:
            self.status = .notPermitted
        }
    }

    func loadMedia(forSection librarySection: LibrarySection) -> [Media] {
        let collections: [MPMediaItemCollection]?
        
        switch librarySection {
        case .playlists: collections = MPMediaQuery.playlists().collections
        case .artists: collections = MPMediaQuery.artists().collections
        case .albums: collections = MPMediaQuery.albums().collections
        case .songs: collections = MPMediaQuery.songs().collections
        case .musicVideos: collections = MPMediaQuery.songs().collections
        case .genres: collections = MPMediaQuery.genres().collections
        case .compilations: collections = MPMediaQuery.compilations().collections
        case .composers: collections = MPMediaQuery.composers().collections
        default: collections = nil
        }
        
        var mediaList = [Media]()
        
        if let collections = collections {
            collections.forEach({ libraryMediaItemCollection in
                guard let libraryMedia = libraryMediaItemCollection.representativeItem else { return }
                
                let kind: MediaKind

                switch libraryMedia.mediaType {
                case .music: kind = MediaKind.song
                case .podcast: kind = MediaKind.podcast
                case .audioBook: kind = MediaKind.audiobook
                case .anyAudio: kind = MediaKind.song
                case .movie: kind = MediaKind.movie
                case .tvShow: kind = MediaKind.tvSeason
                case .musicVideo: kind = MediaKind.musicVideo
                case .movie: kind = MediaKind.movie
                case .anyVideo: kind = MediaKind.musicVideo
                case .any: kind = MediaKind.mix
                default: kind = MediaKind.album
                }
                
                let wrapperType: WrapperType
                
                switch librarySection {
                case .artists: wrapperType = .artist
                case .songs: wrapperType = .track
                default: wrapperType = .collection
                }

                let newLibraryMedia = Media(mediaResponse: MediaResponse(id: libraryMedia.playbackStoreID, artistId: 0, collectionId: 0, trackId: 0, wrapperType: wrapperType.rawValue, kind: kind.rawValue, name: libraryMedia.title, artistName: libraryMedia.artist, collectionName: libraryMedia.albumTitle, trackName: libraryMedia.title, collectionCensoredName: libraryMedia.albumTitle, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: libraryMedia.isExplicitItem ? "explicit" : "notExplicit", discCount: 0, discNumber: nil, trackCount: libraryMedia.albumTrackCount, trackNumber: libraryMedia.albumTrackNumber, trackTimeMillis: libraryMedia.playbackDuration.toInt, country: nil, currency: nil, primaryGenreName: libraryMedia.genre, description: nil, longDescription: nil, releaseDate: libraryMedia.releaseDate?.ISO8601Format().description, contentAdvisoryRating: nil, trackRentalPrice: 0, artwork: libraryMedia.artwork?.image(at: CGSize(width: 1024, height: 1024)), composer: libraryMedia.composer, isCompilation: libraryMedia.isCompilation, dateAdded: libraryMedia.dateAdded))
                
                // Set Recently added albums
                if librarySection == .albums, let oneYearBefore = Calendar.current.date(byAdding: .year, value: -2, to: Date()), libraryMedia.dateAdded >= oneYearBefore {
                    self.recentlyAdded.append(newLibraryMedia)
                }
                
                mediaList.append(newLibraryMedia)
            })
        }
        
        return mediaList
    }
}

// MARK: - Types

extension LibraryObservableObject {
    enum AuthorizationStatus {
        case notYetDetermined
        case permitted
        case notPermitted
    }
}
