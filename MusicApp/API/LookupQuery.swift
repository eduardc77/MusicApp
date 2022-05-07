//
//  LookupQuery.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct LookupQuery: Query {
    var id: String
    
    var toDictionary: [String: String] {
        return [
            "id": id
        ]
    }
}
