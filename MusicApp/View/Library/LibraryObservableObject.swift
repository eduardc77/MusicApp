//
//  LibraryObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import MediaPlayer
import SwiftUI

final class LibraryObservableObject: ObservableObject {
    @Published var playlists = [Media]()
    @Published var artists = [Media]()
    @Published var albums = [Media]()
    @Published var songs = [Media]()
    @Published var madeForYou = [Media]()
    @Published var tvAndMovies = [Media]()
    @Published var musicVideos = [Media]()
    @Published var genres = [Media]()
    @Published var compilations = [Media]()
    @Published var composers = [Media]()
    @Published var downloaded = [Media]()
    @Published var homeSharing = [Media]()
    @Published var recentlyAdded = [Media]()
    
    init() {
        LibrarySection.allCases.forEach { section in
            refreshLibrary(for: section)
        }
    }

    func refreshLibrary(for librarySection: LibrarySection) {
        switch librarySection {
        case .playlists:
            playlists = loadMedia(forSection: .playlists)
        case .artists:
            artists = loadMedia(forSection: .artists)
        case .albums:
            albums = loadMedia(forSection: .albums)
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

    private func loadMedia(forSection librarySection: LibrarySection) -> [Media] {
        let collections: [MPMediaItemCollection]?
        
        switch librarySection {
        case .playlists: collections = MPMediaQuery.playlists().collections
        case .artists: collections = MPMediaQuery.artists().collections
        case .albums: collections = MPMediaQuery.albums().collections
        case .songs: collections = MPMediaQuery.songs().collections
        case .genres: collections = MPMediaQuery.genres().collections
        case .compilations: collections = MPMediaQuery.compilations().collections
        case .composers: collections = MPMediaQuery.composers().collections
        default: collections = nil
        }
        
        var mediaList = [Media]()
        
        if let collections = collections {
            collections.forEach({ libraryMediaItemCollection in
                guard let libraryMedia = libraryMediaItemCollection.representativeItem else { return }
                var image: Image?
                var uiImage: UIImage?
                if let artwork = libraryMedia.artwork?.image(at: CGSize(width: 1024, height: 1024)) {
                    image = Image(uiImage: artwork)
                    uiImage = artwork
                }
                
                let kind: MediaKind
                
                switch libraryMedia.mediaType.rawValue {
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
                
                let wrapperType: WrapperType
                
                switch librarySection {
                case .artists: wrapperType = .artist
                case .songs: wrapperType = .track
                default: wrapperType = .collection
                }
               
                let newLibraryMedia = Media(wrapperType: wrapperType, kind: kind, artistName: libraryMedia.artist, collectionName: libraryMedia.albumTitle, trackName: libraryMedia.title, collectionViewUrl: libraryMedia.assetURL, trackViewUrl: libraryMedia.assetURL, discCount: libraryMedia.discCount, discNumber: libraryMedia.discNumber, trackCount: libraryMedia.albumTrackCount, trackNumber: libraryMedia.albumTrackNumber, trackTimeMillis: libraryMedia.playbackDuration, primaryGenreName: libraryMedia.genre, description: libraryMedia.description, artwork: image, artworkUIImage: uiImage, composer: libraryMedia.composer, isCompilation: libraryMedia.isCompilation, releaseDate: libraryMedia.releaseDate, dateAdded: libraryMedia.dateAdded)
                
                // Set Recently added albums
                if librarySection == .albums, let oneYearBefore = Calendar.current.date(byAdding: .year, value: -1, to: Date()), libraryMedia.dateAdded >= oneYearBefore {
                    self.recentlyAdded.append(newLibraryMedia)
                }
                
                mediaList.append(newLibraryMedia)
            })
        }
        
        return mediaList
    }
}
