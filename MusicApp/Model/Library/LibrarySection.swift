//
//  LibraryListItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import Foundation

enum LibrarySection: String {
  case playlists
  case artists
  case albums
  case songs
  case madeForYou
  case tvAndMovies
  case musicVideos
  case genres
  case compilations
  case composers
  case downloaded
  case homeSharing
  
  var title: String {
    switch self {
    case .madeForYou:
      return "Made For You"
    case .tvAndMovies:
      return "TV And Movies"
    case .musicVideos:
      return "Music Videos"
    case .homeSharing:
      return "Home Sharing"
    default:
      return rawValue.capitalized
    }
  }
  
  var systemImage: String {
    switch self {
    case .playlists:
      return "music.note.list"
    case .artists:
      return "music.mic"
    case .albums:
      return "square.stack"
    case .songs:
      return "music.note"
    case .madeForYou:
      return "person.crop.square"
    case .tvAndMovies:
      return "tv"
    case .musicVideos:
      return "music.note.tv"
    case .genres:
      return "guitars"
    case .compilations:
      return "person.2.crop.square.stack"
    case .composers:
      return "music.quarternote.3"
    case .downloaded:
      return "arrow.down.circle"
    case .homeSharing:
      return "music.note.house"
    }
  }
}

extension LibrarySection: CaseIterable, Codable, Hashable { }
