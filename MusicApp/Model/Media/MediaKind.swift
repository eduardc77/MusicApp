//
//  MediaKind.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

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
    
    var title: String {
        switch self {
        case .album, .song, .artist, .ebook, .movie, .audiobook, .podcast: return self.rawValue.capitalized
        case .playlist: return "Playlists"
        case .musicVideo: return "Music Videos"
        case .tvSeason: return "TV Shows"
        }
    }
    
    var entity: String {
        switch self {
        case .artist: return "musicArtist"
        case .playlist: return "playlists"
        default: return self.rawValue
        }
    }
    
    var titleUppercased: String {
        title.uppercased()
    }
    
    var id: String { self.rawValue }
}

extension MediaKind: CaseIterable, Identifiable, Codable { }
