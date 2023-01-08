//
//  RowButtonStyle.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 08.01.2023.
//

import SwiftUI

struct RowButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.background(configuration.isPressed ? Color.secondary.opacity(0.6) : Color.clear)
			.opacity(configuration.isPressed ? 0.75 : 1)
	}
}

extension ButtonStyle where Self == RowButtonStyle {
	static var rowButton: RowButtonStyle { RowButtonStyle() }
}
