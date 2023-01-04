//
//  TimeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct TimeSliderView: View {
	@ObservedObject var playerObservableObject: PlayerObservableObject

	// MARK: - Private Properties

	@Binding private var trackTimePosition: Int
	@State private var xOffset: CGFloat = 0
	@State private var lastOffset: CGFloat = 0
	@State private var isDragging = false
	@State private var timeBegin: Int = 0
	@State private var timeRemain: Int = 0

	@State var timer = Timer.publish(every: 0.6, tolerance: 0.3, on: .main, in: .default).autoconnect()

	private let trackDuration: Int

	init(playerObservableObject: PlayerObservableObject, trackDuration: Int, trackTimePosition: Binding<Int>) {
		self.playerObservableObject = playerObservableObject
		self.trackDuration = trackDuration
		self._trackTimePosition = trackTimePosition

		_timeBegin = State(wrappedValue: $trackTimePosition.wrappedValue)
		_timeRemain = State(initialValue: trackDuration - timeBegin)
	}


	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				ZStack(alignment: .leading) {
					Capsule()
						.fill(Color.lightGrayColor2)
						.frame(height: Metric.timeLineHeight)
					Capsule()
						.fill(Color.lightGrayColor)
						.frame(width: CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width, height: Metric.timeLineHeight)
					Circle()
						.fill(.white)
						.frame(width: isDragging ? Metric.largePoint : Metric.smallPoint,
								 height: isDragging ? Metric.largePoint : Metric.smallPoint
						)
						.background {
							Circle()
								.fill(.white.opacity(0.01))
								.frame(width: Metric.largePoint, height: Metric.largePoint)
						}
						.offset(x: CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width - (isDragging ? Metric.largePoint / 2 : Metric.smallPoint / 2))
						.gesture(
							DragGesture(minimumDistance: 0)
								.onChanged { value in
									isDragging = true
									timer.upstream.connect().cancel()
									if abs(value.translation.width) < 0.1 {
										lastOffset = CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width
									}

									var sliderPos = max(0, lastOffset + value.translation.width)
									sliderPos = min(sliderPos, geometry.size.width)
									xOffset = sliderPos

									let sliderVal = sliderPos / geometry.size.width * 100
									trackTimePosition = Int(sliderVal * CGFloat(trackDuration) / 100)

									timeBegin = trackTimePosition
									timeRemain = trackDuration - timeBegin
								}
								.onEnded { _ in
									playerObservableObject.audioPlayer.currentPlaybackTime = TimeInterval(trackTimePosition)
									isDragging = false
									timer = Timer.publish(every: 0.6, tolerance: 0.3, on: .main, in: .default).autoconnect()
								}

						)
						.animation(.linear(duration: 0.16), value: isDragging)
				}

				.onReceive(timer) { _ in

					switch playerObservableObject.playerType {
					case .audio:
						guard playerObservableObject.audioPlayer.playbackState == .playing else { return }
						timeBegin = Int(playerObservableObject.audioPlayer.currentPlaybackTime)
						timeRemain = trackDuration - timeBegin
						playerObservableObject.progressRate = playerObservableObject.audioPlayer.currentPlaybackTime.toInt
					case .video:
						guard playerObservableObject.videoPlayer.isPlaying else { return }
						timeBegin = playerObservableObject.videoPlayer.getProgressRate()
						timeRemain = playerObservableObject.videoPlayer.trackDuration - timeBegin
						playerObservableObject.videoPlayer.trackTimePosition = timeBegin
					}
				}
				.frame(height: Metric.largePoint)

				HStack() {
					Text(timeBegin.toTime())
						.font(.caption2).bold()
						.foregroundColor(Color.lightGrayColor2)

					Spacer()

					Text("-" + timeRemain.toTime())
						.font(.caption2).bold()
						.foregroundColor(Color.lightGrayColor2)
				}
			}
		}.padding([.horizontal, .bottom])
	}
}


// MARK: - Previews

struct TimeView_Previews: PreviewProvider {
	struct TimeView: View {
		@StateObject var playerObservableObject = PlayerObservableObject()
		@State var trackTimePosition: Int = 0

		var body: some View {
			VStack {
				TimeSliderView(playerObservableObject: playerObservableObject, trackDuration: 215, trackTimePosition: $trackTimePosition)
			}
			.background(.secondary)
		}
	}

	static var previews: some View {
		TimeView()
	}
}
