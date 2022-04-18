//
//  MediaType.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

enum MediaType: String {
    case album, song, artist, playlist, musicVideo, ebook, movie, tvShow, audiobook, podcast

    var title: String {
        switch self {
        case .album:
            return "Album"
        case .song:
            return "Song"
        case .artist:
            return "Artist"
        case .playlist:
            return "Playlist"
        case .musicVideo:
            return "Music Video"
        case .ebook:
            return "Ebook"
        case .movie:
            return "Movie"
        case .tvShow:
            return "TV Show"
        case .audiobook:
            return "Audio Book"
        case .podcast:
            return "Podcast"
        }
    }

    var entity: String {
        switch self {

        case .album:
            return "album"
        case .song:
            return "song"
        case .artist:
            return "artist"
        case .playlist:
            return "playlist"
        case .musicVideo:
            return "musicVideo"
        case .ebook:
            return "ebook"
        case .movie:
            return "movie"
        case .tvShow:
            return "tvSeason"
        case .audiobook:
            return "audioBook"
        case .podcast:
            return "podcast"
        }
    }

    var id: String { self.rawValue }
}

extension MediaType: CaseIterable, Identifiable, Codable { }
