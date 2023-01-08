//
//  MediaType.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

enum MediaType: String {
	case topResult
	case artist
	case album
	case song
	case musicVideo
	case music
	case podcast
	case podcastAuthor
	case movie
	case tvShow
	case shortFilm
	case audiobook
	case ebook

	var title: String {
		switch self {
		case .topResult: return "Top Results"
		case .artist: return "Artists"
		case .album: return "Albums"
		case .song: return "Songs"
		case .musicVideo: return "Music Videos"
		case .music: return "Playlists"
		case .podcast: return "Podcasts"
		case .podcastAuthor: return "Podcast Authors"
		case .movie: return "Movies"
		case .tvShow: return "TV Shows"
		case .shortFilm: return "Short Films"
		case .audiobook: return "Audiobooks"
		case .ebook: return "Ebooks"
		}
	}

	var titleUppercased: String { title.uppercased() }

	var entity: [String] {
		switch self {
		case .topResult: return ["song", "musicVideo", "album", "musicArtist"]
		case .artist: return ["musicArtist"]
		case .album: return ["album"]
		case .song: return ["song"]
		case .musicVideo: return ["musicVideo"]
		case .music: return ["mix"]
		case .podcast: return ["podcast"]
		case .podcastAuthor: return ["podcastAuthor"]
		case .movie: return ["movie"]
		case .tvShow: return ["tvEpisode"]
		case .shortFilm: return ["shortFilm"]
		case .audiobook: return ["audiobook"]
		case .ebook: return ["ebook"]
		}
	}
}

extension MediaType: CaseIterable, Codable { }
