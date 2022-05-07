//
//  SearchQuery.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct SearchQuery: Query {
    var term: String
    var media: MediaKind
    var limit: Int = 16
    var offset: Int = 0
    
    var toDictionary: [String: String] {
        return [
            "term": term,
            "media": media.rawValue,
            "entity": media.entity,
            "limit": String(limit),
            "offset": String(offset)
        ]
    }
}
