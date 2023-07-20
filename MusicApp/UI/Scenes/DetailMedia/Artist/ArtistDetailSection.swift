//
//  ArtistDetailSection.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.01.2023.
//

import Foundation


enum ArtistDetailSection {
   case featuredAlbum
   case topSongs
   case albums
   case musicVideos
   case singlesAndEps
   case appearsOn
   
   var title: String {
      switch self {
      case .featuredAlbum:
         return "Featured Album"
      case .topSongs:
         return "Top Songs"
      case .albums:
         return "Albums"
      case .musicVideos:
         return "Music Videos"
      case .singlesAndEps:
         return "Singles & EPs"
      case .appearsOn:
         return "Appears On"
      }
   }
}

extension ArtistDetailSection: CaseIterable {}
