//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@State private var offset: CGFloat = 0
	@State private var visibleSide: FlipViewSide = .front
	@State private var playing: Bool = false

	var body: some View {
		VStack {
			if playerObservableObject.expand { handleBar }

			HStack(spacing: 12) {
				mediaView

				if !playerObservableObject.expand { smallPlayerViewDetails }
			}
			.padding([.vertical, .leading])
			.padding(.trailing, 8)
			.frame(height: playerObservableObject.expand ? Metric.screenHeight / 2.2 :  Metric.playerHeight)

			if playerObservableObject.expand {
				VStack {
					HStack {
						expandedMediaDetails
						Spacer()
						ellipsisButton
					}
					expandedControlsBlock.padding(.horizontal)
				}
				.frame(height: playerObservableObject.expand ? Metric.screenHeight / 2.8 : 0)
				.opacity(playerObservableObject.expand ? 1 : 0)
				.transition(.move(edge: .bottom))
			}
		}
		.frame(maxHeight: playerObservableObject.expand ? .infinity : Metric.playerHeight)
		.background(playerBackground)
		.offset(y: playerObservableObject.expand ? 0 : Metric.tabBarHeight)
		.offset(y: offset)
		.ignoresSafeArea()
		.gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))

		.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)) { _ in
			playerObservableObject.playbackState = PlayerObservableObject.audioPlayer.playbackState

			switch playerObservableObject.playbackState {
			case .playing:
				playing = true
			default:
				playing = false
			}
		}

		.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)) { _ in
			playerObservableObject.playerType = .audio
			guard let mediaItem = PlayerObservableObject.audioPlayer.nowPlayingItem else { return }
			playerObservableObject.progressRate = PlayerObservableObject.audioPlayer.currentPlaybackTime.toInt
			playerObservableObject.makeNowPlaying(media: mediaItem, playing: $playing)
		}
	}

	// Drag Player
	private func onChanged(value: DragGesture.Value) {
		withAnimation(.linear) {
			if value.translation.height > 0 && playerObservableObject.expand {
				offset = value.translation.height
			}
		}
	}

	// Close Player
	private func onEnded(value: DragGesture.Value) {
		withAnimation(.closePlayer) {
			if value.translation.height > Metric.screenHeight / 12 {
				playerObservableObject.expand = false
			}
			offset = 0
		}
	}
}

// MARK: - Subviews

private extension PlayerView {
	@ViewBuilder
	var handleBar: some View {
		Capsule()
			.fill(Color.lightGrayColor2)
			.frame(width: Metric.capsuleWidth, height: Metric.capsuleHeight)
			.opacity(playerObservableObject.expand ? 1 : 0)
	}

	@ViewBuilder
	var mediaView: some View {
		if playerObservableObject.playerType == .video {
			playerObservableObject.videoPlayer
				.frame(width: playerObservableObject.expand ? SizeType.largeHighlight.size.width : SizeType.smallPlayerVideo.size.width, height: playerObservableObject.expand ? SizeType.largeHighlight.size.height : SizeType.smallPlayerVideo.size.height)
				.cornerRadius(playerObservableObject.expand ? 0 : Metric.defaultCornerRadius)
		} else {
			MediaImageView(imagePath: playerObservableObject.nowPlayingItem.media.artworkPath.resizedPath(size: 600), artworkImage: playerObservableObject.nowPlayingItem.media.artwork, sizeType: playerObservableObject.expand ? .largePlayerArtwork : .trackRowItem, cornerRadius: playerObservableObject.expand ? 10 : Metric.defaultCornerRadius, shadowProminence: playerObservableObject.expand ? .full : .none, visibleSide: $visibleSide)
				.scaleEffect((playerObservableObject.playbackState == .playing && playerObservableObject.expand) ? 1.33 : 1)
				.animation(playerObservableObject.expand ? .scaleCard : .none, value: playerObservableObject.playbackState)

				.onTapGesture {
					guard playerObservableObject.expand else { return }
					visibleSide.toggle()
				}
		}
	}

	@ViewBuilder
	var smallPlayerViewDetails: some View {
		HStack {
			Text(playerObservableObject.nowPlayingItem.media.trackName)
				.lineLimit(1)
				.font(.title3)
			Spacer()

			HStack(spacing: 0) {
				Button {
					playerObservableObject.playbackState == .playing ? PlayerObservableObject.audioPlayer.pause() : PlayerObservableObject.audioPlayer.play()
				} label: {
					playerObservableObject.playbackState == .playing ?
					Image(systemName: "pause.fill")
					:
					Image(systemName: "play.fill")
				}
				.font(.title).imageScale(.small)
				.buttonStyle(.circle)

				Button {
					PlayerObservableObject.audioPlayer.skipToNextItem()
				} label: {
					Image(systemName: "forward.fill")
				}
				.font(.title).imageScale(.small)
				.buttonStyle(.circle)
			}
			.foregroundColor(!playerObservableObject.nowPlayingItem.media.name.isEmpty ? .primary : .secondary)
		}
		.frame(maxWidth: .infinity)
	}

	@ViewBuilder
	var expandedMediaDetails: some View {
		VStack(alignment: .leading, spacing: 2) {
			InfiniteScrollText(text: playerObservableObject.nowPlayingItem.media.mediaResponse.name != nil ? playerObservableObject.nowPlayingItem.media.name : "Not Playing", explicitness: playerObservableObject.nowPlayingItem.media.trackExplicitness)

			Menu {
				Button { } label: {
					HStack {
						VStack {
							Text("Go to Album")

							Text(playerObservableObject.nowPlayingItem.media.collectionName)
						}
						.font(.caption2)

						Image(systemName: "square.stack")
					}
				}

				Button { } label: {
					HStack {
						VStack {
							Text("Go to Artist")
							Text(playerObservableObject.nowPlayingItem.media.artistName)
						}.font(.caption2)

						Image(systemName: "music.mic")
					}
				}
			} label: {
				InfiniteScrollText(text: playerObservableObject.nowPlayingItem.media.artistName, textColor: playerObservableObject.playerType == .audio ? .lightGrayColor : .accentColor, font: UIFont.systemFont(ofSize: 20))
			}
		}
	}

	@ViewBuilder
	var ellipsisButton: some View {
		if playerObservableObject.playerType == .audio {
			Button(action: { }) {
				Image(systemName: "ellipsis.circle.fill")
					.font(.title)
					.foregroundStyle(.white, Color.lightGrayColor3)
			}
			.padding(.trailing, 30)
			.padding(.leading, 6)
		} else {
			Button(action: { }) {
				Image(systemName: "ellipsis.circle.fill")
					.font(.title)
					.foregroundStyle(Color.accentColor, Color.accentColor.opacity(0.2))
			}
			.padding(.trailing, 30)
			.padding(.leading, 6)
		}
	}

	@ViewBuilder
	var expandedControlsBlock: some View {
		VStack {
			switch playerObservableObject.playerType {
			case .audio:
				TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: PlayerObservableObject.audioPlayer.nowPlayingItem?.playbackDuration.toInt ?? 1, trackTimePosition: $playerObservableObject.progressRate)
			case .video:
				TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: playerObservableObject.videoPlayer.trackDuration, trackTimePosition: $playerObservableObject.videoPlayer.trackTimePosition)
			}
			PlayerControls()

			VolumeView(playerType: playerObservableObject.playerType)
		}
	}

	@ViewBuilder
	var playerBackground: some View {
		Group {
			if playerObservableObject.expand {
				if let artworkUIImage = playerObservableObject.nowPlayingItem.media.artwork, playerObservableObject.playerType == .audio {
					LinearGradient(
						gradient: Gradient(colors: [Color(artworkUIImage.firstAverageColor ?? .gray),
															 Color(artworkUIImage.secondAverageColor ?? .gray)]),
						startPoint: .topLeading,
						endPoint: .bottomTrailing)
					.transition(.move(edge: .bottom).combined(with: .opacity))
				} else {
					Color(.black)
				}
			} else {
				VStack(spacing: 0) {
					BlurView()
					Divider()
				}
			}
		}
		.onTapGesture {
			withAnimation(Animation.openPlayer) {
				playerObservableObject.expand = true
			}
		}
	}
}


// MARK: - Previews

struct PlayerView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()

			PlayerView()

				.environmentObject(PlayerObservableObject())
		}.ignoresSafeArea()
	}
}
