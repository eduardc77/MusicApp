//
//  VideoPlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 14.05.2022.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
  @State var expand = false
  @State var beenExpanded = false
  @State var isPlaying = false
  @State var trackTimePosition = 1
  @State var trackDuration = 1
  private var sizeType: SizeType
  private var cornerRadius: CGFloat
  var videoAssetUrl: URL = URL(string: "https://www.apple.com/404")!
  
  var player: AVPlayer = AVPlayer()
  
  init(videoAssetUrl: URL, sizeType: SizeType = .defaultSize, cornerRadius: CGFloat = Metric.defaultCornerRadius) {
    self.sizeType = sizeType
    self.cornerRadius = cornerRadius
    self.videoAssetUrl = videoAssetUrl
  }
  
  var body: some View {
    PlayerViewController(player: player, videoAssetUrl: videoAssetUrl, expand: $expand, beenExpanded: $beenExpanded)
      .onChange(of: isPlaying) { newValue in
        togglePlayPause(newValue)
      }
    
      .onAppear {
        expand = false

      }
      .onDisappear {
        guard !expand else { return }
        beenExpanded = false
        isPlaying = false
        player.pause()
        player.replaceCurrentItem(with: nil)
      }
      .onTapGesture {
        expand.toggle()
      }
  }
  
  func getProgressRate() -> Int {
    if player.currentItem?.status == .readyToPlay {
      return Int(player.currentTime().seconds)
    } else {
      return 0
    }
  }

  private func togglePlayPause(_ newValue: Bool) {
    
    if newValue {
      player.play()
    }
    else {
      player.pause()
    }
  }
  
  func toggleIsPlaying() {
    isPlaying.toggle()
  }
}

struct PlayerViewController: UIViewControllerRepresentable {
  var player: AVPlayer
  var videoAssetUrl: URL
  @Binding var expand: Bool
  @Binding var beenExpanded: Bool
  
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let playerVC = AVPlayerViewController()
    playerVC.player = player
    playerVC.exitsFullScreenWhenPlaybackEnds = true
    return playerVC
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    if expand {
      DispatchQueue.main.async() {
        uiViewController.enterFullScreen()
        uiViewController.showsPlaybackControls = true
        beenExpanded = true
      }
    } else {
      if !beenExpanded {
        resetPlayer(uiViewController)
        let asset = AVAsset(url: videoAssetUrl)
        let item = AVPlayerItem(asset: asset)
        uiViewController.player?.replaceCurrentItem(with: item)
        uiViewController.player?.play()
      }
      uiViewController.showsPlaybackControls = false
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.46) {
        uiViewController.player?.play()
      }
    }
  }
  
  func resetPlayer(_ vc: AVPlayerViewController) {
    vc.player?.pause()
    vc.player?.replaceCurrentItem(with: nil)
  }
}

extension AVPlayerViewController {
  func enterFullScreen(animated: Bool = true) {
    perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
  }
}


// MARK: - Previews

struct VideoPlayerView_Previews: PreviewProvider {
	struct VideoPlayerViewExample: View {
		@State var expand: Bool = false

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

