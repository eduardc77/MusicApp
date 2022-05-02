//
//  MediaKind.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

enum MediaKind: String {
    case album
    case song
    case artist
    case playlist
    case musicVideo
    case ebook
    case movie
    case tvSeason
    case audiobook
    case podcast
    case mix

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
        case .tvSeason:
            return "TV Show"
        case .audiobook:
            return "Audio Book"
        case .podcast:
            return "Podcast"
        case .mix:
            return "Mix"
        }
    }

    var entity: String {
        self.rawValue
    }
    
    var entityUppercased: String {
        self.rawValue.uppercased()
    }

    var id: String { self.rawValue }
}

extension MediaKind: CaseIterable, Identifiable, Codable { }
