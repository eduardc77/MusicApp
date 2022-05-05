//
//  Animation+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(response: 1 + Double.random(in: -0.3...0.9), dampingFraction: 0, blendDuration: 0.6)
            .speed(1.6)
            .delay(0.03 * Double(index))
            .repeatForever()
    }
    
    static let openCard = Animation.spring(response: 0.45, dampingFraction: 0.9)
    static let closeCard = Animation.spring(response: 0.35, dampingFraction: 1)
    static let flipCard = Animation.spring(response: 0.35, dampingFraction: 0.7)
}
