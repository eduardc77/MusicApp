//
//  Kind.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

enum Kind: String {
    case ebook
    case movie = "feature-movie"
    case tvShow = "tv-episode"

    var mediaType: MediaType {
        switch self {
        case .ebook:
            return MediaType.ebook
        case .movie:
            return MediaType.movie
        case .tvShow:
            return MediaType.tvShow
        }
    }
}
