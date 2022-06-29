//
//  ItunesAPIResponse.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ITunesAPIResponse: Decodable {
    let results: [MediaResponse]
}

struct MediaResponse: Codable {
    let id: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let wrapperType: String?
    let kind: String?
    let name: String?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionHdPrice: Double?
    let trackPrice: Double?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let description: String?
    let longDescription: String?
    let releaseDate: String?
    let contentAdvisoryRating: String?
    let trackRentalPrice: Double?
    
    // MARK: - Library Properties
    var artwork: UIImage?
    var composer: String?
    var isCompilation: Bool?
    var dateAdded: Date?
    
    init(id: String? = nil, artistId: Int? = nil, collectionId: Int? = nil, trackId: Int? = nil, wrapperType: String? = nil, kind: String? = nil, name: String? = nil, artistName: String? = nil, collectionName: String? = nil, trackName: String? = nil, collectionCensoredName: String? = nil, artistViewUrl: String? = nil, collectionViewUrl: String? = nil, trackViewUrl: String? = nil, previewUrl: String? = nil, artworkUrl100: String? = nil, collectionPrice: Double? = nil, collectionHdPrice: Double? = nil, trackPrice: Double? = nil, collectionExplicitness: String? = nil, trackExplicitness: String? = nil, discCount: Int? = nil, discNumber: Int? = nil, trackCount: Int? = nil, trackNumber: Int? = nil, trackTimeMillis: Int? = nil, country: String? = nil, currency: String? = nil, primaryGenreName: String? = nil, description: String? = nil, longDescription: String? = nil, releaseDate: String? = nil, contentAdvisoryRating: String? = nil, trackRentalPrice: Double? = nil, artwork: UIImage? = nil, composer: String? = nil, isCompilation: Bool? = nil, dateAdded: Date? = nil) {
         self.id = id
         self.artistId = artistId
         self.collectionId = collectionId
         self.trackId = trackId
         self.wrapperType = wrapperType
         self.kind = kind
         self.name = name
         self.artistName = artistName
         self.collectionName = collectionName
         self.trackName = trackName
         self.collectionCensoredName = collectionCensoredName
         self.artistViewUrl = artistViewUrl
         self.collectionViewUrl = collectionViewUrl
         self.trackViewUrl = trackViewUrl
         self.previewUrl = previewUrl
         self.artworkUrl100 = artworkUrl100
         self.collectionPrice = collectionPrice
         self.collectionHdPrice = collectionHdPrice
         self.trackPrice = trackPrice
         self.collectionExplicitness = collectionExplicitness
         self.trackExplicitness = trackExplicitness
         self.discCount = discCount
         self.discNumber = discNumber
         self.trackCount = trackCount
         self.trackNumber = trackNumber
         self.trackTimeMillis = trackTimeMillis
         self.country = country
         self.currency = currency
         self.primaryGenreName = primaryGenreName
         self.description = description
         self.longDescription = longDescription
         self.releaseDate = releaseDate
         self.contentAdvisoryRating = contentAdvisoryRating
         self.trackRentalPrice = trackRentalPrice
         self.artwork = artwork
         self.composer = composer
         self.isCompilation = isCompilation
         self.dateAdded = dateAdded
     }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case artistId
        case collectionId
        case trackId
        case wrapperType
        case kind
        case name
        case artistName
        case collectionName
        case trackName
        case collectionCensoredName
        case artistViewUrl
        case collectionViewUrl
        case trackViewUrl
        case previewUrl
        case artworkUrl100
        case collectionPrice
        case collectionHdPrice
        case trackPrice
        case collectionExplicitness
        case trackExplicitness
        case discCount
        case discNumber
        case trackCount
        case trackNumber
        case trackTimeMillis
        case country
        case currency
        case primaryGenreName
        case description
        case longDescription
        case releaseDate
        case contentAdvisoryRating
        case trackRentalPrice
    }
}
