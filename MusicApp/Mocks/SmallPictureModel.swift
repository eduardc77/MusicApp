//
//  SmallPictureModel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct SmallPictureModel: Hashable, Identifiable {
	var id = UUID()
	var image: String
	var name: String
	var description: String
}

var radioStations = [
	SmallPictureModel(image: "smallradio0", name: "Up Next", description: "Apple Music"),
	SmallPictureModel(image: "smallradio1", name: "Africa Now", description: "Apple Music"),
	SmallPictureModel(image: "smallradio2", name: "John Legend", description: "Apple Music"),
	SmallPictureModel(image: "smallradio3", name: "Placeholder", description: "Apple Music"),
	SmallPictureModel(image: "smallradio4", name: "Billie Eilish", description: "Apple Music"),
	SmallPictureModel(image: "smallradio5", name: "Placeholder", description: "Apple Music"),
	SmallPictureModel(image: "smallradio6", name: "Placeholder", description: "Apple Music")
]

var musicPlaylists: [Media] = [
	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "collection", kind: "Album", name: "Shoot Down the Moon", artistName: "Elton John", collectionName: "Ice on Fire", trackName: "Shoot Down the Moon", collectionCensoredName: "Ice on Fire", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p0"), composer: "Elton John", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Her Go", artistName: "Passenger", collectionName: "Let Her Go", trackName: "Let Her Go", collectionCensoredName: "Let Her Go", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p1"), composer: "Passenger", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Bad Blood", artistName: "Taylor Swift", collectionName: "1989", trackName: "Bad Blood", collectionCensoredName: "1989", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p2"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Believer", artistName: "Imagine Dragons", collectionName: "Zycon Bootleg", trackName: "Believer", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p3"), composer: "Imagine Dragons", isCompilation: nil)),
	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Her Go", artistName: "Passenger", collectionName: "Let Her Go", trackName: "Let Her Go", collectionCensoredName: "Let Her Go", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p1"), composer: "Passenger", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Bad Blood", artistName: "Taylor Swift", collectionName: "1989", trackName: "Bad Blood", collectionCensoredName: "1989", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p2"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Believer", artistName: "Imagine Dragons", collectionName: "Zycon Bootleg", trackName: "Believer", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p3"), composer: "Imagine Dragons", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Blank Space", artistName: "Taylor Swift", collectionName: "Single", trackName: "Blank Space", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p6"), composer: "Taylor Swift", isCompilation: nil))
]

var musicPlaylists2: [Media] = [
	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 70936, collectionId: 251001680, trackId: 251002253, wrapperType: "collection", kind: "Album", name: "Shoot Down the Moon", artistName: "Elton John", collectionName: "Ice on Fire", trackName: "Shoot Down the Moon", collectionCensoredName: "Ice on Fire", artistViewUrl: "https://itunes.apple.com/us/artist/johnny-cash/id70936?uo=4", collectionViewUrl: "https://itunes.apple.com/us/album/ring-of-fire/id251001680?i=251002253&uo=4", trackViewUrl: "https://itunes.apple.com/us/album/ring-of-fire/id251001680?i=251002253&uo=4", previewUrl: "http://a1144.phobos.apple.com/us/r1000/070/Music/b3/99/be/mzi.qvkhtgfg.aac.p.m4a", artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p0"), composer: "Elton John", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Her Go", artistName: "Passenger", collectionName: "Let Her Go", trackName: "Let Her Go", collectionCensoredName: "Let Her Go", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p1"), composer: "Passenger", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Bad Blood", artistName: "Taylor Swift", collectionName: "1989", trackName: "Bad Blood", collectionCensoredName: "1989", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p2"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Believer", artistName: "Imagine Dragons", collectionName: "Zycon Bootleg", trackName: "Believer", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p3"), composer: "Imagine Dragons", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Me Love You", artistName: "DJ Snake", collectionName: "Single", trackName: "Let Me Love You", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p4"), composer: "DJ Snake", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Shape Of You", artistName: "Ed Sheeran", collectionName: "Essentials", trackName: "Shape Of You", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p5"), composer: "Ed Sheeran", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Blank Space", artistName: "Taylor Swift", collectionName: "Single", trackName: "Blank Space", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p6"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Star Shopping", artistName: "Lil Peep", collectionName: "Essentials", trackName: "Star Shopping", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p7"), composer: "Lil Peep", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Red", artistName: "Taylor Swift", collectionName: "Red", trackName: "Red", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p8"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "I Like It", artistName: "Cardi B", collectionName: "Single", trackName: "I Like It", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p9"), composer: "Cardi B", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Lover", artistName: "Taylor Swift", collectionName: "Lover", trackName: "Lover", collectionCensoredName: "Lover", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p10"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Joanne", artistName: "Lady Gaga", collectionName: "Joanne", trackName: "Joanne", collectionCensoredName: "Joanne", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p11"), composer: "Lady Gaga", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Star Shopping", artistName: "Artist Name", collectionName: "Essentials", trackName: "Star Shopping", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p12"), composer: "Artist Name", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Closer", artistName: "Saweetie", collectionName: "Closer", trackName: "Closer", collectionCensoredName: "Closer", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p13"), composer: "Saweetie", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "STARGAZING", artistName: "Travis Scott", collectionName: "Astroworld", trackName: "STARGAZING", collectionCensoredName: "Astroworld", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p14"), composer: "Travis Scott", isCompilation: nil)),
	
	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Nikita", artistName: "Elton John", collectionName: "Ice on Fire", trackName: "Nikita", collectionCensoredName: "Ice on Fire", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p0"), composer: "Elton John", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Her Go", artistName: "Passenger", collectionName: "Let Her Go", trackName: "Let Her Go", collectionCensoredName: "Let Her Go", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p1"), composer: "Passenger", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Bad Blood", artistName: "Taylor Swift", collectionName: "1989", trackName: "Bad Blood", collectionCensoredName: "1989", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p2"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Believer", artistName: "Imagine Dragons", collectionName: "Zycon Bootleg", trackName: "Believer", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop Alternative", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p3"), composer: "Imagine Dragons", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Let Me Love You", artistName: "DJ Snake", collectionName: "Single", trackName: "Let Me Love You", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p4"), composer: "DJ Snake", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Shape Of You", artistName: "Ed Sheeran", collectionName: "Essentials", trackName: "Shape Of You", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p5"), composer: "Ed Sheeran", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Blank Space", artistName: "Taylor Swift", collectionName: "Single", trackName: "Blank Space", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p6"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Star Shopping", artistName: "Lil Peep", collectionName: "Essentials", trackName: "Star Shopping", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p7"), composer: "Lil Peep", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Red", artistName: "Taylor Swift", collectionName: "Red", trackName: "Red", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p8"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "I Like It", artistName: "Cardi B", collectionName: "Single", trackName: "I Like It", collectionCensoredName: "Single", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p9"), composer: "Cardi B", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Lover", artistName: "Taylor Swift", collectionName: "Lover", trackName: "Lover", collectionCensoredName: "Lover", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "notExplicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Pop", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p10"), composer: "Taylor Swift", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Joanne", artistName: "Lady Gaga", collectionName: "Joanne", trackName: "Joanne", collectionCensoredName: "Joanne", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p11"), composer: "Lady Gaga", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Star Shopping", artistName: "Artist Name", collectionName: "Essentials", trackName: "Star Shopping", collectionCensoredName: "Essentials", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p12"), composer: "Artist Name", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "track", kind: "Album", name: "Closer", artistName: "Saweetie", collectionName: "Closer", trackName: "Closer", collectionCensoredName: "Closer", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p13"), composer: "Saweetie", isCompilation: nil)),

	Media(mediaResponse: MediaResponse(id: UUID().uuidString, artistId: 0, collectionId: 0, trackId: 0, wrapperType: "album", kind: "Album", name: "Astroworld", artistName: "Travis Scott", collectionName: "Astroworld", trackName: "STARGAZING", collectionCensoredName: "Astroworld", artistViewUrl: nil, collectionViewUrl: nil, trackViewUrl: nil, previewUrl: nil, artworkUrl100: nil, collectionPrice: nil, collectionHdPrice: 0, trackPrice: 0, collectionExplicitness: nil, trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 10, trackNumber: 1, trackTimeMillis: 3000, country: "USA", currency: "USD", primaryGenreName: "Hip-Hop/Rap", description: "Description", longDescription: nil, releaseDate: Date().ISO8601Format(), contentAdvisoryRating: nil, trackRentalPrice: 10, artwork: UIImage(named: "p14"), composer: "Travis Scott", isCompilation: nil))
]
