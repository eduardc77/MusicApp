//
//  Media.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct Media: Identifiable, Codable {
    let mediaResponse: MediaResponse

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
    var collectionExplicitness: String { String(mediaResponse.collectionExplicitness ?? "notExplicit") }
    var trackExplicitness: String? { String(mediaResponse.trackExplicitness ?? "notExplicit") }
    var discCount: String { String(mediaResponse.discCount ?? 0) }
    var discNumber: String { String(mediaResponse.discNumber ?? 0) }
    var trackCount: String { String(mediaResponse.trackCount ?? 0) }
    var trackNumber: String { String(mediaResponse.trackNumber ?? 0) }
    var trackTimeMillis: Double? { Double(mediaResponse.trackTimeMillis ?? 0) }
    var currency: String { (" " + (mediaResponse.currency ?? "No price")) }
    var country: String { mediaResponse.country ?? "" }
    
    var wrapperType: WrapperType { WrapperType(rawValue: mediaResponse.wrapperType ?? "") ?? .collection }
    
    var kind: MediaKind { MediaKind(rawValue: mediaResponse.kind ?? "") ?? .album }
     
    var name: String {
        mediaResponse.name ?? mediaResponse.trackName ?? mediaResponse.collectionName ?? "Unknown media"
    }

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

    var iTunesUrl: URL {
        URL(string: mediaResponse.trackViewUrl ?? "") ?? URL(string: "https://www.apple.com/404")!
    }

    var previewUrl: URL {
        URL(string: mediaResponse.previewUrl ?? "") ?? Bundle.main.url(forResource: "Placeholder", withExtension: "mov")!
    }

    var id: String {
        mediaResponse.id ?? mediaResponse.trackId?.description ?? mediaResponse.collectionId?.description ?? mediaResponse.artistId?.description ?? UUID().uuidString
    }

    var shortInfo: [ShortInfoType] {
        ShortInfoType.allCases.filter( { $0.title(for: self) != "0" && $0.title(for: self) != "0.0" } )
    }
    
    // MARK: - Library Properties
    
    var artwork: UIImage? {
        return mediaResponse.artwork ?? nil
    }

    var composer: String? { String(mediaResponse.composer ?? "") }
    var isCompilation: Bool? { Bool(mediaResponse.isCompilation ?? false) }

    enum ShortInfoType: String, CaseIterable, Identifiable {
        case advisory = "Advisory rating"
        case genre = "Genre"
        case releaseDate = "Release date"
        case duration = "Duration"
        case rentalPrice = "Movie rental price"
        case moviesInCollection = "Movies in collection"
        case collectionHDPrice = "Collection HD price"

        var id: String { rawValue }

        func title(for media: Media) -> String {
            switch self {
            case .advisory:
                return media.advisory
            case .genre:
                return media.genreName
            case .releaseDate:
                return media.releaseDate ?? ""
            case .duration:
                return media.duration
            case .rentalPrice:
                return media.rentalPrice
            case .moviesInCollection:
                return media.trackCount
            case .collectionHDPrice:
                return media.collectionPrice + media.currency
            }
        }
    }
}

extension Media: Equatable, Hashable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: -

enum DefaultString {
    static let undefined = "Undefined"
}
