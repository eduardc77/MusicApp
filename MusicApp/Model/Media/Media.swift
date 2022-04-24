//
//  Media.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct Media: Identifiable {
    var id: String
    var trackName: String?
    var artistName: String?
    var description: String?
    var kind: MediaKind?
    var genres: [String]?
    var trackPrice: String?
    var artworkUrl100: URL?
    var artwork: UIImage?
    var previewUrl: URL?
    var collectionName: String?
    var trackTimeMillis: Double?
    var releaseDate: Date?
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Media: Codable {
    enum CodingKeys: String, CodingKey {
        case genres, releaseDate, description, previewUrl, kind, trackName, trackPrice, artworkUrl100, artistName, trackTimeMillis, collectionName
        case id = "trackId"
    }

    enum AdditionalKeys: String, CodingKey {
        case longDescription
        case primaryGenreName
        case wrapperType
        case trackPrice
        case collectionId
        case collectionName
        case collectionPrice
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let additionalContainer = try decoder.container(keyedBy: AdditionalKeys.self)

        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = String(id)
        } else {
            self.id = String(try additionalContainer.decode(Int.self, forKey: .collectionId))
        }

        if let name = try? container.decode(String.self, forKey: .trackName) {
            trackName = name
        } else {
            trackName = try additionalContainer.decode(String.self, forKey: .collectionName)
        }

        if let kind = try? container.decode(String.self, forKey: .kind) {
            self.kind = MediaKind(rawValue: kind) ?? .artist
        } else {
            let wrapperType = try additionalContainer.decode(String.self, forKey: .wrapperType)
            self.kind = MediaKind(rawValue: wrapperType) ?? .artist
        }
        artistName = try container.decode(String.self, forKey: .artistName)
        artworkUrl100 = try container.decode(URL.self, forKey: .artworkUrl100)
        previewUrl = (try? container.decode(URL.self, forKey: .previewUrl)) ?? nil
        trackTimeMillis = try container.decode(Double.self, forKey: .trackTimeMillis)
        collectionName = try container.decode(String.self, forKey: .collectionName)
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)

        if let description = try? container.decode(String.self, forKey: .description) {
            self.description = description.stripHTML()
        } else if let description = try? additionalContainer.decode(String.self, forKey: .longDescription) {
            self.description = description.stripHTML()
        } else {
            description = "No description."
        }

        if let genres = try? container.decode([String].self, forKey: .genres) {
            self.genres = genres
        } else if let genre = try? additionalContainer.decode(String.self, forKey: .primaryGenreName) {
            genres = [genre]
        } else {
            genres = []
        }

        if let price = try? container.decode(String.self, forKey: .trackPrice) {
            self.trackPrice = price
        } else if let price = try? additionalContainer.decode(String.self, forKey: .trackPrice) {
            self.trackPrice = price
        } else if let number = (try? additionalContainer.decode(Double.self, forKey: .collectionPrice)) {
            self.trackPrice = "$\(number)"
        } else {
            trackPrice = ""
        }
    }
}

// MARK: Sample data for Media
extension Media {
    static let sampleData: [Media] = (0...6).map { _ in Media.singleMedia }
    static let singleMedia = Media(
        id: "1436991868",
        trackName: "Run from Ruin",
        artistName: "Steven King",
        description:
        """
        They’re not undead; they’re just angry…  \
        The DataMind meditation app has revolutionized the world, \
        making people smarter, happier, and more productive. But a \
        programming glitch in the final update causes billions of \
        users to experience uncontrollable rage and aggression. \
        <br /><br />Nick, an ordinary high school senior in Fairbanks \
        Alaska, is suddenly thrust into this life or death arena. \
        He and his brother must escape the zombie-like hordes of \
        blood-thirsty maniacs and seek refuge north of the arctic \
        circle.<br /><br />The four-hundred-mile journey tests the \
        boys, their wits, and their trust in each other. They think \
        they’re fighting to stay alive; but little do they know, \
        they’re fighting to save mankind.
        """,
        kind: .ebook,
        genres: ["Horror", "Books", "Fiction & Literature", "Sci-Fi & Fantasy"],
        trackPrice: "Free",
        artworkUrl100: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Publication125/v4/0d/b4/db/0db4db25-4fc4-52f0-492c-95d3d3daec86/9780463068281.jpg/100x100bb.jpg")!,
        previewUrl: nil,
        collectionName: "Album",
        trackTimeMillis: 1000,
        releaseDate: Date().addingTimeInterval(-1 * 3 * 365 * 24 * 60 * 60))
}

enum DefaultString {
    static let undefined = "Undefined"
}
