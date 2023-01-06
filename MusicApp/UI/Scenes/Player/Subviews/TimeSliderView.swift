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
	@State private var timer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
	private let trackDuration: Int
	private var scaleAnimationDuration = 0.15

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
					Rectangle()
						.fill(Color.lightGrayColor2)
						.frame(height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
					Rectangle()
						.fill(Color.lightGrayColor)
						.frame(width: CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width, height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
						//.animation(.linear(duration: isDragging && timeBegin != 0 && timeRemain != trackDuration ? 0 : 1), value: timeRemain)
				}
				.clipShape(Capsule(style: .continuous))

				.onReceive(timer) { _ in
					switch playerObservableObject.playerType {
					case .audio:
						guard PlayerObservableObject.audioPlayer.playbackState == .playing else { return }
						timeBegin = Int(PlayerObservableObject.audioPlayer.currentPlaybackTime)
						timeRemain = trackDuration - timeBegin
						playerObservableObject.progressRate = PlayerObservableObject.audioPlayer.currentPlaybackTime.toInt
					case .video:
						guard playerObservableObject.videoPlayer.isPlaying else { return }
						timeBegin = playerObservableObject.videoPlayer.getProgressRate()
						timeRemain = playerObservableObject.videoPlayer.trackDuration - timeBegin
						playerObservableObject.videoPlayer.trackTimePosition = timeBegin
					}
				}
				.frame(height: Metric.trackTimeSliderHeight)

				HStack() {
					Text(timeBegin.toTime())
						.font(.caption2).bold()
						.foregroundColor( isDragging ? .white.opacity(0.9) : Color.lightGrayColor2)

					Spacer()

					Text("-" + timeRemain.toTime())
						.font(.caption2).bold()
						.foregroundColor( isDragging ? .white.opacity(0.9) : Color.lightGrayColor2)
				}
			}
			.contentShape(Rectangle())

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
						PlayerObservableObject.audioPlayer.currentPlaybackTime = TimeInterval(trackTimePosition)
						DispatchQueue.main.asyncAfter(deadline: .now() + scaleAnimationDuration) {
							isDragging = false
							timer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
						}
					}
			)
		}
		.padding([.horizontal, .bottom])
		.padding(.top, 8)
		.scaleEffect(x: isDragging ? 1.06 : 1, y: isDragging ? 1.16 : 1)
		.animation(.linear(duration:scaleAnimationDuration), value: isDragging)
		
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
