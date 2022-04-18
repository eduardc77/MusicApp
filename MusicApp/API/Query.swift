//
//  Query.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

protocol Query {
    var toDictionary: [String: String] { get }
}
