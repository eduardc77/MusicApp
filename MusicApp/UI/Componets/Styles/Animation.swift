//
//  Animation.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

extension Animation {
	static func ripple(index: Int) -> Animation {
		Animation.spring(response: 1 + Double.random(in: -0.3...0.9), dampingFraction: 0, blendDuration: Double.random(in: -0.3...0.9))
			.speed(1.6)
			.delay(0.03 * Double(index))
			.repeatForever()
	}

	static let openPlayer = Animation.easeOut(duration: 0.2)
	static let closePlayer =  Animation.easeOut(duration: 0.3)
	static let flipCard = Animation.interactiveSpring(response: 0.35, dampingFraction: 0.7)
	static let scaleCard = Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)
}
