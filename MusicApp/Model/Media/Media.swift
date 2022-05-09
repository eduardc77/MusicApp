//
//  Media.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct Media {
    var id: String = UUID().uuidString
    
    var wrapperType: WrapperType?
    var kind: MediaKind?
    var artistId: Int?
    var collectionId: Int?
    var trackId: Int?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var collectionCensoredName: String?
    var artistViewUrl: URL?
    var collectionViewUrl: URL?
    var trackViewUrl: URL?
    var previewUrl: URL?
    var artworkUrl60: URL?
    var artworkUrl100: URL?
    var collectionPrice: Double?
    var trackPrice: Double?
    var collectionExplicitness: String?
    var trackExplicitness: String?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var trackTimeMillis: Double?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    
    var description: String?
    var longDescription: String?
    
    // Library Properties
    var artwork: Image?
    var artworkUIImage: UIImage?
    var composer: String?
    var isCompilation: Bool?
    var releaseDate: Date?
    var dateAdded: Date?
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Media: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Media: Codable {
    private enum CodingKeys: String, CodingKey {
        case wrapperType, kind, artistId, collectionId, trackId, artistName, collectionName, trackName, collectionCensoredName, artistViewUrl, collectionViewUrl, trackViewUrl, previewUrl, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, description, longDescription, releaseDate
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        if let wrapperType = try? container?.decode(String.self, forKey: .wrapperType),
           let mediaKind = WrapperType(rawValue: wrapperType) {
            self.wrapperType = mediaKind
        } else {
            wrapperType = .collection
        }
        
        if let kind = try? container?.decode(String.self, forKey: .kind),
           let mediaKind = MediaKind(rawValue: kind) {
            self.kind = mediaKind
        } else {
            kind = .album
        }
        
        if let trackId = try? container?.decode(Int.self, forKey: .trackId) {
            id = String(trackId)
            self.trackId = trackId
        } else if let collectionId = try? container?.decode(Int.self, forKey: .collectionId) {
            id = String(collectionId)
            self.collectionId = collectionId
        } else if let artistId = try? container?.decode(Int.self, forKey: .artistId) {
            id = String(artistId)
            self.artistId = artistId
        }
        artistName = try? container?.decode(String.self, forKey: .artistName)
        collectionName = try? container?.decode(String.self, forKey: .collectionName)
        trackName = try? container?.decode(String.self, forKey: .trackName)
        collectionCensoredName = try? container?.decode(String.self, forKey: .collectionCensoredName)
        artistViewUrl = try? container?.decode(URL.self, forKey: .artistViewUrl)
        collectionViewUrl = try? container?.decode(URL.self, forKey: .collectionViewUrl)
        trackViewUrl = try? container?.decode(URL.self, forKey: .trackViewUrl)
        previewUrl = (try? container?.decode(URL.self, forKey: .previewUrl)) ?? nil
        artworkUrl60 = (try? container?.decode(URL.self, forKey: .artworkUrl60)) ?? nil
        artworkUrl100 = try? container?.decode(URL.self, forKey: .artworkUrl100)
        
        collectionExplicitness = try? container?.decode(String.self, forKey: .collectionExplicitness)
        trackExplicitness = try? container?.decode(String.self, forKey: .trackExplicitness)
        discCount = try? container?.decode(Int.self, forKey: .discCount)
        discNumber = try? container?.decode(Int.self, forKey: .discNumber)
        trackCount = try? container?.decode(Int.self, forKey: .trackCount)
        trackNumber = try? container?.decode(Int.self, forKey: .trackNumber)
        trackTimeMillis = try? container?.decode(Double.self, forKey: .trackTimeMillis)
        country = try? container?.decode(String.self, forKey: .country)
        currency = try? container?.decode(String.self, forKey: .currency)
        primaryGenreName = try? container?.decode(String.self, forKey: .primaryGenreName)
        releaseDate = try? container?.decode(Date.self, forKey: .releaseDate)
        
        if let description = try? container?.decode(String.self, forKey: .description) {
            self.description = description.stripHTML()
        } else if let description = try? container?.decode(String.self, forKey: .longDescription) {
            self.longDescription = description.stripHTML()
        } else {
            description = "No description."
            longDescription = ""
        }
        
        if let trackPrice = try? container?.decode(Double.self, forKey: .trackPrice) {
            self.trackPrice = trackPrice
        } else if let collectionPrice = try? container?.decode(Double.self, forKey: .collectionPrice) {
            self.collectionPrice = collectionPrice
        } else {
            trackPrice = 0.0
            collectionPrice = 0.0
        }
    }
}

enum DefaultString {
    static let undefined = "Undefined"
}
