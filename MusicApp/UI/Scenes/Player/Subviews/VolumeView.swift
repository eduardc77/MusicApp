//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct VolumeView: View {
	@ObservedObject private var volumeObserver = VolumeObserver()
	var playerType: PlayerType = .audio

	var binding: Binding<Double> {
		Binding(get: {
            volumeObserver.volume ?? Double(VolumeObserver.session.outputVolume)
		}, set: {
			volumeObserver.volume = $0
			MPVolumeView.setVolume(Float($0))
		})
	}
	
	var body: some View {
		LabeledSlider(value: binding, in: 0...1) {
			Text("Volume")
		} minimumValueLabel: {
			Image(systemName: "speaker.fill")
		} maximumValueLabel: {
			Image(systemName: "speaker.wave.3.fill")
		}
		.mySliderStyle(.custom)
		.padding(.horizontal)
		.tint(.lightGrayColor)
	}
}

extension MPVolumeView {
	static func setVolume(_ volume: Float) {
		let systemVolumeView = MPVolumeView(frame: .zero)

		let slider = systemVolumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
			slider?.isHidden = true
			slider?.clipsToBounds = false
			slider?.alpha = .zero
			slider?.value = volume
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
