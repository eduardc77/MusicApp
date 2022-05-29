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
