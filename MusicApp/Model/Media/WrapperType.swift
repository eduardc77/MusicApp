//
//  WrapperType.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 01.05.2022.
//

import Foundation

enum WrapperType: String {
    case track
    case collection
    case artist
}

extension WrapperType: Codable {}
