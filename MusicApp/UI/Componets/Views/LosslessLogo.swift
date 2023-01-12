//
//  LosslessLogo.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 10.01.2023.
//

import SwiftUI

struct LosslessLogo: View {
   var bordered: Bool = true
	var color: Color = .lightGrayColor2

	var body: some View {
		HStack(spacing: 3) {
			Image("lossless-logo")
				.resizable()
				.scaledToFit()
				.frame(width: 18, height: 16)

			Text("Lossless")
				.font(.system(size: 11, weight: .medium))
		}
		.foregroundColor(color)
		.padding(.horizontal, bordered ? 6.6 : 0)

		.overlay {
			if bordered {
				Capsule(style: .continuous)
					.stroke(color, lineWidth: 0.8)
			}
		}
	}
}


// MARK: - Previews

struct LosslessLogo_Previews: PreviewProvider {
	static var previews: some View {
		LosslessLogo()
	}
}
