//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct PlayerView: View {
	@EnvironmentObject private var model: PlayerObservableObject
	@State private var offset: CGFloat = 0
	@State private var visibleSide: FlipViewSide = .front

	var body: some View {
		VStack(spacing: 0) {
			handleBar

			HStack(spacing: 0) {
				mediaView

				if !model.expand {
					smallPlayerViewDetails
						.padding(.leading, 12)
						.padding(.trailing, 6)
				}
			}
			.padding(.leading, model.expand ? 0 : nil)
			.frame(height: model.expand ? Metric.screenHeight / 2 :  Metric.playerHeight)

			if model.expand {
				VStack {
					HStack {
						expandedMediaDetails
						Spacer()
						ellipsisButton
					}
					Spacer()
					expandedControlsBlock.padding(.horizontal)
				}
				.frame(height: model.expand ? Metric.screenHeight / 2.74 : 0)
				.opacity(model.expand ? 1 : 0)
				.transition(.move(edge: .bottom))
			}
		}

		.frame(maxHeight: model.expand ? .infinity : Metric.playerHeight)
		.background(playerBackground)
		.offset(y: model.expand ? 0 : Metric.tabBarHeight)
		.offset(y: offset)
		.ignoresSafeArea()
		.gesture(DragGesture().onEnded(onEnded).onChanged(onChanged))

		.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)) { _ in
			model.playbackState = PlayerObservableObject.audioPlayer.playbackState
		}

		.onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)) { _ in
			guard let mediaItem = PlayerObservableObject.audioPlayer.nowPlayingItem else { return }
			model.setNowPlaying(media: mediaItem)
		}
	}
}

// MARK: - Private Methods

private extension PlayerView {
	// Drag Player
	func onChanged(value: DragGesture.Value) {
		withAnimation(.linear) {
			if value.translation.height > 0 && model.expand {
				offset = value.translation.height
			}
		}
	}

	// Close Player
	func onEnded(value: DragGesture.Value) {
		withAnimation(.closePlayer) {
			if value.translation.height > Metric.screenHeight / 12 {
				model.expand = false
			}
			offset = 0
		}
	}

	func expandPlayer() {
		withAnimation(.openPlayer) {
			model.expand = true
		}
	}
}

// MARK: - Subviews

private extension PlayerView {
	@ViewBuilder
	var handleBar: some View {
		Capsule()
			.fill(Color.lightGrayColor2)
			.frame(width: Metric.capsuleWidth, height: model.expand ? Metric.capsuleHeight : 0)
			.opacity(model.expand ? 1 : 0)
	}

	@ViewBuilder
	var mediaView: some View {
		if model.playerType == .video {
			model.videoPlayer
				.frame(width: model.expand ? SizeType.none.size.width : SizeType.smallPlayerVideo.size.width, height: model.expand ? SizeType.none.size.height : SizeType.smallPlayerVideo.size.height)
				.cornerRadius(model.expand ?  SizeType.none.cornerRadius : SizeType.smallPlayerVideo.cornerRadius)
		} else {
			MediaImageView(imagePath: model.nowPlayingItem.artworkPath.resizedPath(size: 600), artworkImage: model.nowPlayingItem.artwork, sizeType: model.expand ? .largePlayerArtwork : .smallPlayerAudio, shadowProminence: model.expand ? .full : .none, visibleSide: $visibleSide)
				.scaleEffect((model.playbackState == .playing && model.expand) ? 1.33 : 1)
				.animation(model.expand ? .scaleCard : .none, value: model.playbackState)

				.onTapGesture {
					guard model.expand else {
						expandPlayer()
						return
					}
					visibleSide.toggle()
				}
		}
	}

	@ViewBuilder
	var smallPlayerViewDetails: some View {
		HStack {
			Text(model.nowPlayingItem.trackName)
				.lineLimit(1)
				.font(.title3)
			Spacer()

			HStack(spacing: 0) {
				Button {
					model.playbackState == .playing ? PlayerObservableObject.audioPlayer.pause() : PlayerObservableObject.audioPlayer.play()
				} label: {
					model.playbackState == .playing ? Image(systemName: "pause.fill") : Image(systemName: "play.fill")
				}
				.font(.title).imageScale(.medium)
				.buttonStyle(.circle)

				Button {
					PlayerObservableObject.audioPlayer.skipToNextItem()
				} label: {
					Image(systemName: "forward.fill")
				}
				.font(.title).imageScale(.small)
				.buttonStyle(.circle)
			}
			.foregroundColor(!model.nowPlayingItem.name.isEmpty ? .primary : .secondary)
		}
	}

	@ViewBuilder
	var expandedMediaDetails: some View {
		VStack(alignment: .leading, spacing: 0) {
			InfiniteScrollText(text: model.nowPlayingItem.mediaResponse.trackName != nil ? model.nowPlayingItem.trackName : "Not Playing", explicitness: model.nowPlayingItem.trackExplicitness, font: UIFont.systemFont(ofSize: 20, weight: .semibold))

			Menu {
				Button { } label: {
					HStack {
						VStack {
							Text("Go to Album")

							Text(model.nowPlayingItem.collectionName)
						}
						.font(.caption2)

						Image(systemName: "square.stack")
					}
				}

				Button { } label: {
					HStack {
						VStack {
							Text("Go to Artist")
							Text(model.nowPlayingItem.artistName)
						}.font(.caption2)

						Image(systemName: "music.mic")
					}
				}
			} label: {
				InfiniteScrollText(text: model.nowPlayingItem.artistName, textColor: model.playerType == .audio ? .lightGrayColor : .appAccentColor)
			}
		}
	}

	@ViewBuilder
	var ellipsisButton: some View {
		Group {
			switch model.playerType {
			case .audio:
				MenuButton(circled: true, font: .title, foregroundColor: .white)
			case .video:
				MenuButton(circled: true, font: .title, foregroundColor: .appAccentColor)
			}
		}
		.padding(.trailing, 30)
		.padding(.leading, 6)
	}

	@ViewBuilder
	var expandedControlsBlock: some View {
		VStack {
			TimeSliderView()
			Spacer()
			PlayerControls()
			Spacer()
			VolumeView(playerType: model.playerType)
			Spacer()
			BottomToolbar(playerType: model.playerType)
		}
	}

	@ViewBuilder
	var playerBackground: some View {
		Group {
			if model.expand {
				switch model.playerType {
				case .audio:
					if let artworkUIImage = model.nowPlayingItem.artwork {
						LinearGradient(
							gradient: Gradient(colors: [Color(artworkUIImage.firstAverageColor ?? .gray),
																 Color(artworkUIImage.secondAverageColor ?? .gray)]),
							startPoint: .topLeading,
							endPoint: .bottomTrailing)
					} else {
						Color(.gray)
					}
				case .video:
					// Video Player background
					Color(.black)
				}
			} else {
				VStack(spacing: 0) {
					BlurView()
					Divider()
				}
			}
		}
		.scaleEffect(y: 1, anchor: .bottom)
		.onTapGesture {
			guard !model.expand else { return }
			expandPlayer()
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
		}
		.ignoresSafeArea()
	}
}
