//
//  Media.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayableItem {
  @Binding var playing: Bool
  
  var media: Media
}

struct Media: Identifiable, Codable {
  var mediaResponse: MediaResponse
  
  var id: String { mediaResponse.id ?? mediaResponse.trackId?.description ?? mediaResponse.collectionId?.description ?? mediaResponse.artistId?.description ?? UUID().uuidString }
  var name: String { mediaResponse.name ?? mediaResponse.trackName ?? mediaResponse.collectionName ?? "Unknown media" }
  var wrapperType: WrapperType { WrapperType(rawValue: mediaResponse.wrapperType ?? "") ?? .collection }
  var kind: MediaKind { MediaKind(rawValue: mediaResponse.kind ?? "") ?? .album }
  var artistId: Int { mediaResponse.artistId ?? 0 }
  var collectionId: Int { mediaResponse.collectionId ?? 0 }
  var trackId: Int { mediaResponse.trackId ?? 0 }
  var artistName: String { mediaResponse.artistName ?? "" }
  var collectionName: String { mediaResponse.collectionName ?? "" }
  var trackName: String { mediaResponse.trackName ?? "" }
  var artworkPath: String { mediaResponse.artworkUrl100 ?? "" }
  var genreName: String { mediaResponse.primaryGenreName ?? "" }
  var description: String { mediaResponse.longDescription ?? "" }
  var advisory: String { mediaResponse.contentAdvisoryRating ?? "Unrated" }
  var rentalPrice: String { String(mediaResponse.trackRentalPrice ?? 0) }
  var collectionPrice: String { String(mediaResponse.collectionHdPrice ?? mediaResponse.collectionPrice ?? 0) }
  var collectionCensoredName: String { String(mediaResponse.collectionHdPrice ?? 0) }
  var artistViewUrl: String { String(mediaResponse.collectionHdPrice ?? 0) }
  var collectionViewUrl: String { String(mediaResponse.collectionHdPrice ?? 0) }
  var trackViewUrl: String { String(mediaResponse.collectionHdPrice ?? 0) }
  var trackPrice: Double { Double(mediaResponse.trackPrice ?? 0) }
  var discCount: String { String(mediaResponse.discCount ?? 0) }
  var discNumber: String { String(mediaResponse.discNumber ?? 0) }
  var trackCount: String { String(mediaResponse.trackCount ?? 0) }
  var trackNumber: String { String(mediaResponse.trackNumber ?? 0) }
  var trackTimeMillis: Double? { Double(mediaResponse.trackTimeMillis ?? 0) }
  var currency: String { (" " + (mediaResponse.currency ?? "No price")) }
  var country: String { mediaResponse.country ?? "" }
  var collectionExplicitness: Explicitness { return Explicitness(rawValue: mediaResponse.collectionExplicitness ?? "notExplicit") ?? .notExplicit }
  var trackExplicitness: Explicitness { return Explicitness(rawValue: mediaResponse.trackExplicitness ?? "notExplicit") ?? .notExplicit }
  var iTunesUrl: URL { URL(string: mediaResponse.trackViewUrl ?? "") ?? URL(string: "https://www.apple.com/404")! }
  var previewUrl: URL { URL(string: mediaResponse.previewUrl ?? "") ?? Bundle.main.url(forResource: "Placeholder", withExtension: "mov")! }
  
  var releaseDate: String? {
    guard let releaseDateString = mediaResponse.releaseDate,
          let formattedDate = DateFormatter.isoFormatter.date(from: releaseDateString)?.addingTimeInterval(86400) else {
      return nil
    }
    
    return DateFormatter.defaultFormatter.string(from: formattedDate)
  }
  
  var releaseYear: String? {
    guard let releaseDateString = mediaResponse.releaseDate,
          let formattedDate = DateFormatter.isoFormatter.date(from: releaseDateString)?.addingTimeInterval(86400) else {
      return nil
    }
    return DateFormatter.yearFormatter.string(from: formattedDate)
  }
  
  var dateAdded: Date? {
    guard let date = mediaResponse.dateAdded else { return nil }
    return date
  }
  
  var genreAndReleaseYear: String {
    guard let releaseYear = releaseYear else {
      return "\(genreName.uppercased())"
    }
    
    return "\(genreName.uppercased()) · \(releaseYear)"
  }
  
  var albumAndReleaseYear: String {
    guard let releaseYear = releaseYear else {
      return "\(collectionName)"
    }
    
    return "\(collectionName) · \(releaseYear)"
  }
  
  var duration: String {
    let seconds = (mediaResponse.trackTimeMillis ?? 0) / 1000
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = .short
    return formatter.string(from: TimeInterval(seconds)) ?? "nil"
  }
  
  // MARK: - Library Properties
  
  var artwork: UIImage? { return mediaResponse.artwork ?? nil }
  var composer: String? { String(mediaResponse.composer ?? "") }
  var isCompilation: Bool? { Bool(mediaResponse.isCompilation ?? false) }
  
  init() {
    mediaResponse = MediaResponse(id: nil, artistId: nil, collectionId: nil, trackId: nil, wrapperType: nil, kind: nil, name: nil, artistName: nil, collectionName: nil, trackName: nil, collectionCensoredName: nil, artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: nil, trackPrice: nil, collectionExplicitness: nil, trackExplicitness: nil, discCount: nil, discNumber: nil, trackCount: nil, trackNumber: nil, trackTimeMillis: nil, country: nil, currency: nil, primaryGenreName: nil, description: nil, longDescription: nil, releaseDate: nil, contentAdvisoryRating: nil, trackRentalPrice: nil)
  }
  
  init(mediaResponse: MediaResponse) {
    self.mediaResponse = mediaResponse
  }
}

// MARK: - Equatable
extension Media: Equatable {
  static func == (lhs: Media, rhs: Media) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - Hashable

extension Media: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
