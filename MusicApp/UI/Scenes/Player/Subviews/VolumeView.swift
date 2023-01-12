//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VolumeView: View {
	var playerType: PlayerType = .audio

	var body: some View {
		VStack {
			HStack {
				Image(systemName: "speaker.fill")

				VolumeSlider()
					.controlSize(.regular)
					.accentColor(.lightGrayColor)
					.offset(y: 4)

				Image(systemName: "speaker.wave.2.fill")
			}
			.foregroundColor(.lightGrayColor)
			.frame(width: UIScreen.main.bounds.width * 0.82, height: 24)
			.padding(.top)

			Spacer()
			BottomToolbar(playerType: playerType)
		}
	}
}


// MARK: - Previews

struct VolumeView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()

			VolumeView()
				.background(.secondary)
				.frame(height: 100)
				.padding()
		}
	}
}
