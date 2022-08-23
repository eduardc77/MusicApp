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
    PlayerViewController(player: player, videoAssetUrl: videoAssetUrl)
      .onChange(of: isPlaying) { newValue in
        togglePlayPause(newValue)
      }

      .onAppear {
        isPlaying = true
        trackDuration = getDurationSeconds()
      }
      .onDisappear {
        isPlaying = false
        player.pause()
      }
  }

  func getProgressRate() -> Int {
    if player.currentItem?.status == .readyToPlay {
      return Int(player.currentTime().seconds)
    } else {
      return 0
    }
  }

  func getDurationSeconds() -> Int {
    guard let durationInSeconds = player.currentItem?.asset.duration.seconds else { return 0 }

    return Int(durationInSeconds)
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

  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let playerVC = AVPlayerViewController()
    playerVC.player = player
    return playerVC
  }

  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    resetPlayer(uiViewController)
    let asset = AVAsset(url: videoAssetUrl)
    let item = AVPlayerItem(asset: asset)
    uiViewController.player?.replaceCurrentItem(with: item)
    uiViewController.player?.play()
  }

  func resetPlayer(_ vc: AVPlayerViewController) {
    vc.player?.pause()
    vc.player?.replaceCurrentItem(with: nil)
  }
}
