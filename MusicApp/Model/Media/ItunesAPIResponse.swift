//
//  ItunesAPIResponse.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

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
    let name: String? //?? Delete maybe
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl60: String?
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
}
