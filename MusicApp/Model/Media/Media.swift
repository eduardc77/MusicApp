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
    var artworkUrl60: String { String(mediaResponse.artworkUrl60 ?? "") }
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
    
//    var composer: String? = ""
//    var isCompilation: Bool? = false
//    var dateAdded: Date? = Date()
    
    var wrapperType: WrapperType { WrapperType(rawValue: mediaResponse.wrapperType ?? "") ?? .collection }
    
    var kind: MediaKind { MediaKind(rawValue: mediaResponse.kind ?? "") ?? .album }
     
    var name: String {
        mediaResponse.name ?? mediaResponse.trackName ?? mediaResponse.collectionName ?? "Unknown media"
    }

    var releaseDate: String {
        guard let date = DateFormatter.isoFormatter.date(from: mediaResponse.releaseDate ?? "") else {
            return ""
        }
        return DateFormatter.defaultFormatter.string(from: date)
    }

    var duration: String {
        let seconds = (mediaResponse.trackTimeMillis ?? 0) / 1000
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        return formatter.string(from: TimeInterval(seconds)) ?? "nil"
    }

    var iTunesLink: URL {
        URL(string: mediaResponse.trackViewUrl ?? "") ?? URL(string: "https://www.apple.com/404")!
    }

    var trailerLink: URL {
        URL(string: mediaResponse.previewUrl ?? "") ?? Bundle.main.url(forResource: "Placeholder", withExtension: "mov")!
    }

    var id: String {
        mediaResponse.id ?? mediaResponse.trackId?.description ?? mediaResponse.collectionId?.description ?? mediaResponse.artistId?.description ?? UUID().uuidString
    }

    var shortInfo: [ShortInfoType] {
        ShortInfoType.allCases.filter( { $0.title(for: self) != "0" && $0.title(for: self) != "0.0" } )
    }
    
    static func initWithNoValues() -> Media {
        return Media(mediaResponse: MediaResponse(id: "0", artistId: 0, collectionId: 0, trackId: 0, wrapperType: "", kind: "", name: "", artistName: "", collectionName: "", trackName: "", collectionCensoredName: "", artistViewUrl: "", collectionViewUrl: "", trackViewUrl: "", previewUrl: "", artworkUrl60: "", artworkUrl100: "", collectionPrice: 0, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: "", trackExplicitness: "", discCount: 0, discNumber: 0, trackCount: 0, trackNumber: 0, trackTimeMillis: 0, country: "", currency: "", primaryGenreName: "", description: "", longDescription: "", releaseDate: "", contentAdvisoryRating: "", trackRentalPrice: 0))
    }

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
                return media.releaseDate
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




//    var name: String
//
//    var collectionCensoredName: String?
//    var artistViewUrl: URL?
//    var collectionViewUrl: URL?
//    var trackViewUrl: URL?
//    var previewUrl: URL?
//    var artworkUrl60: URL?
//    var artworkUrl100: String
//    var collectionPrice: Double?
//    var trackPrice: Double?
//    var collectionExplicitness: String?
//    var trackExplicitness: String?
//    var discCount: Int?
//    var discNumber: Int?
//    var trackCount: Int?
//    var trackNumber: Int?
//    var trackTimeMillis: Double?
//    var country: String?
//    var currency: String?
//    var primaryGenreName: String
//
//    var description: String?
//    var longDescription: String?
//
//    // Library Properties
//    var artwork: Image?
//    var artworkUIImage: UIImage?
//    var composer: String?
//    var isCompilation: Bool?
//    var releaseDate: Date?
//    var dateAdded: Date?
//}
//
//extension Media: Equatable {
//    static func == (lhs: Media, rhs: Media) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//
//extension Media: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//extension Media: Codable {
//    private enum CodingKeys: String, CodingKey {
//        case wrapperType, kind, artistId, collectionId, trackId, name, artistName, collectionName, trackName, collectionCensoredName, artistViewUrl, collectionViewUrl, trackViewUrl, previewUrl, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, description, longDescription, releaseDate
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try? decoder.container(keyedBy: CodingKeys.self)
//
//        if let wrapperType = try? container?.decode(String.self, forKey: .wrapperType),
//           let mediaKind = WrapperType(rawValue: wrapperType) {
//            self.wrapperType = mediaKind
//        } else {
//            wrapperType = .collection
//        }
//
//        if let kind = try? container?.decode(String.self, forKey: .kind),
//           let mediaKind = MediaKind(rawValue: kind) {
//            self.kind = mediaKind
//        } else {
//            kind = .album
//        }
//
//        if let trackId = try? container?.decode(Int.self, forKey: .trackId) {
//            id = String(trackId)
//            self.trackId = trackId
//        } else if let collectionId = try? container?.decode(Int.self, forKey: .collectionId) {
//            id = String(collectionId)
//            self.collectionId = collectionId
//        } else if let artistId = try? container?.decode(Int.self, forKey: .artistId) {
//            id = String(artistId)
//            self.artistId = artistId
//        }
//        name = try? container?.decode(String.self, forKey: .name)
//        artistName = try? container?.decode(String.self, forKey: .artistName)
//        collectionName = try? container?.decode(String.self, forKey: .collectionName)
//        trackName = try? container?.decode(String.self, forKey: .trackName)
//        collectionCensoredName = try? container?.decode(String.self, forKey: .collectionCensoredName)
//        artistViewUrl = try? container?.decode(URL.self, forKey: .artistViewUrl)
//        collectionViewUrl = try? container?.decode(URL.self, forKey: .collectionViewUrl)
//        trackViewUrl = try? container?.decode(URL.self, forKey: .trackViewUrl)
//        previewUrl = (try? container?.decode(URL.self, forKey: .previewUrl)) ?? nil
//        artworkUrl60 = (try? container?.decode(URL.self, forKey: .artworkUrl60)) ?? nil
//        artworkUrl100 = try? container?.decode(URL.self, forKey: .artworkUrl100)
//
//        collectionExplicitness = try? container?.decode(String.self, forKey: .collectionExplicitness)
//        trackExplicitness = try? container?.decode(String.self, forKey: .trackExplicitness)
//        discCount = try? container?.decode(Int.self, forKey: .discCount)
//        discNumber = try? container?.decode(Int.self, forKey: .discNumber)
//        trackCount = try? container?.decode(Int.self, forKey: .trackCount)
//        trackNumber = try? container?.decode(Int.self, forKey: .trackNumber)
//        trackTimeMillis = try? container?.decode(Double.self, forKey: .trackTimeMillis)
//        country = try? container?.decode(String.self, forKey: .country)
//        currency = try? container?.decode(String.self, forKey: .currency)
//        primaryGenreName = try? container?.decode(String.self, forKey: .primaryGenreName)
//        releaseDate = try? container?.decode(Date.self, forKey: .releaseDate)
//
//        if let description = try? container?.decode(String.self, forKey: .description) {
//            self.description = description.stripHTML()
//        } else if let description = try? container?.decode(String.self, forKey: .longDescription) {
//            self.longDescription = description.stripHTML()
//        } else {
//            description = "No description."
//            longDescription = ""
//        }
//
//        if let trackPrice = try? container?.decode(Double.self, forKey: .trackPrice) {
//            self.trackPrice = trackPrice
//        } else if let collectionPrice = try? container?.decode(Double.self, forKey: .collectionPrice) {
//            self.collectionPrice = collectionPrice
//        } else {
//            trackPrice = 0.0
//            collectionPrice = 0.0
//        }
//    }
//}
//

