//
//  VideoPlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import AVKit
import Combine

struct VideoPlayerView: View {
	let player: AVPlayer = AVPlayer()
	@State var expand = false
	private var sizeType: SizeType
	private var cornerRadius: CGFloat
	private var videoAssetUrl: URL = URL(string: "https://www.apple.com/404")!

	var trackTimePosition: Int {
		if player.currentItem?.status == .readyToPlay  {
			return CMTimeGetSeconds(player.currentTime()).toInt
		} else {
			return 0
		}
	}

	var trackDuration: Int {
		if player.currentItem?.status == .readyToPlay, CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero).toInt != 0 {
			return CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero).toInt
		} else {
			return 1
		}
	}

	init(videoAssetUrl: URL, sizeType: SizeType = .none, cornerRadius: CGFloat = SizeType.none.cornerRadius) {
		self.sizeType = sizeType
		self.cornerRadius = cornerRadius
		self.videoAssetUrl = videoAssetUrl
	}

	var body: some View {
		AVPlayerControllerRepresentable(player: player, videoAssetUrl: videoAssetUrl, expand: $expand)
			.onTapGesture {
				expand.toggle()
			}
	}

	func toggleIsPlaying() {
		if player.timeControlStatus == .playing {
			player.pause()
		} else {
			player.play()
		}
	}
}

struct AVPlayerControllerRepresentable: UIViewControllerRepresentable {
	var player: AVPlayer
	var videoAssetUrl: URL
	@Binding var expand: Bool
	@State private var beenExpanded: Bool = false

	func makeUIViewController(context: UIViewControllerRepresentableContext<AVPlayerControllerRepresentable>) -> AVPlayerViewController {
		let controller  = AVPlayerViewController()
		controller.player = player

		player.preventsDisplaySleepDuringVideoPlayback = true
		player.allowsExternalPlayback = true

		controller.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
		context.coordinator.playerController = controller

		return controller
	}

	func updateUIViewController(_  uiViewController: AVPlayerViewController , context: UIViewControllerRepresentableContext<AVPlayerControllerRepresentable>) {
		if expand {
			DispatchQueue.main.async() {
				uiViewController.showsPlaybackControls = true
				enterFullScreen(for: uiViewController)
			}
		} else {
			if !beenExpanded {
				uiViewController.showsPlaybackControls = false
				let asset = AVAsset(url: videoAssetUrl)
				let item = AVPlayerItem(asset: asset)
				replacePlayerItem(for: uiViewController, with: item)
				uiViewController.player?.play()
			} else {
				DispatchQueue.main.async() {
					exitFullScreen(for: uiViewController)
				}
			}

		}

		func enterFullScreen(for playerController: AVPlayerViewController, animated: Bool = true) {
			beenExpanded = true
			playerController.perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
		}

		func exitFullScreen(for playerController: AVPlayerViewController, animated: Bool = true) {
			playerController.perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)

			expand = false
		}

		func replacePlayerItem(for vc: AVPlayerViewController, with item: AVPlayerItem) {
			DispatchQueue.global(qos: .background).async {
				vc.player?.replaceCurrentItem(with: item)
			}
		}
	}

	class Coordinator: NSObject, AVPlayerViewControllerDelegate {
		weak var playerController: AVPlayerViewController? {
			didSet {
				playerController?.delegate = self
			}
		}
		private var subscriber: AnyCancellable? = nil

		override init() {
			super.init()

			subscriber = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
				.sink { [weak self] _ in
					self?.deviceRotated()
				}
		}

		func deviceRotated() {
			if UIDevice.current.orientation.isLandscape {
				self.enterFullScreen(animated: true)
			}
		}

		func enterFullScreen(animated: Bool = true) {
			playerController?.showsPlaybackControls = true
			playerController?.perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
		}

		func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
			coordinator.animate(alongsideTransition: nil) { transitionContext in
				playerViewController.player?.play()

			}
		}
	}



	func makeCoordinator() -> Coordinator {
		Coordinator()
	}
}

// MARK: - Previews

struct VideoPlayerView_Previews: PreviewProvider {
	struct VideoPlayerViewExample: View {
		var body: some View {
			VStack {
				Spacer()

				VideoPlayerView(videoAssetUrl: URL(string: "https://www.apple.com/404")!)
					.frame(width: 400, height: 260)
			}
		}
	}

	static var previews: some View {
		VideoPlayerViewExample()
			.environmentObject(PlayerObservableObject())
	}
}

