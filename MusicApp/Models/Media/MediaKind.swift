//
//  MediaKind.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 07.01.2023.
//

enum MediaKind: String {
	case album
	case song
	case artist
	case mix
	case musicVideo
	case interactiveBooklet
	case featureMovie
	case tvEpisode
	case ebook
	case podcastEpisode

	var value: String {
		switch self {
		case .interactiveBooklet: return "interactive-booklet"
		case .featureMovie: return "feature-movie"
		case .podcastEpisode: return "podcast-episode"
		case .musicVideo: return "music-video"
		case .tvEpisode: return "tv-episode"
		default: return self.rawValue
		}
	}

	var title: String {
		switch self {
		case .musicVideo: return "Music Video"
		case .podcastEpisode: return "Podcast"
		case .tvEpisode: return "TV Show"
		case .interactiveBooklet: return "Ebook"
		case .featureMovie: return "Movie"
		default: return self.value.capitalized
		}
	}

	var titleUppercased: String { title.uppercased() }
}

extension MediaKind: CaseIterable, Codable { }
