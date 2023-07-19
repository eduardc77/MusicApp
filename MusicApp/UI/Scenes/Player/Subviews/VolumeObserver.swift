//
//  VolumeObserver.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.02.2023.
//

import Foundation
import MediaPlayer

final class VolumeObserver: ObservableObject {
	@Published var volume: Double?

	// Audio session object
	static let session = AVAudioSession.sharedInstance()

	// Observer
	private var progressObserver: NSKeyValueObservation?
    
	func subscribe() {
		do {
            try VolumeObserver.session.setCategory(AVAudioSession.Category.ambient)
            try VolumeObserver.session.setActive(true, options: .notifyOthersOnDeactivation)

			UIApplication.shared.beginReceivingRemoteControlEvents()
		} catch {
			print("Cannot activate AVAudioSession.")
		}

        progressObserver = VolumeObserver.session.observe(\.outputVolume) { [weak self] (session, value) in
			DispatchQueue.main.async {
				self?.volume = Double(session.outputVolume)
			}
		}
	}

	func unsubscribe() {
		self.progressObserver?.invalidate()
	}

	init() {
        volume = Double(VolumeObserver.session.outputVolume)
		subscribe()
	}

	deinit {
		unsubscribe()
	}
}

