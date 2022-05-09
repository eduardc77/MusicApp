//
//  ItunesAPIResponse.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct ITunesAPIResponse: Decodable {
    var results: [Media]
}
