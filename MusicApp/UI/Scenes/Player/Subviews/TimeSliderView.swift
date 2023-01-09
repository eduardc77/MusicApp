//
//  TimeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct TimeSliderView: View {
	@EnvironmentObject private var model: PlayerObservableObject

	// MARK: - Private Properties

	@State private var xOffset: CGFloat = 0
	@State private var lastOffset: CGFloat = 0
	@State private var isDragging = false
	@State private var trackTimePosition: Int = 0
	@State private var timeRemain: Int = 0
	@State private var timer = Timer.publish(every: 0, on: .main, in: .default).autoconnect()
	@State private var trackDuration: Int = 0
	private var scaleAnimationDuration = 0.15

	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				ZStack(alignment: .leading) {
					Rectangle()
						.fill(Color.lightGrayColor2)
						.frame(height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
					Rectangle()
						.fill(Color.lightGrayColor)
						.frame(width: (trackDuration != 0) ? (CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width) : CGFloat.zero,
								 height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
				}
				.clipShape(Capsule(style: .continuous))

				.onReceive(timer) { _ in
					switch model.playerType {
					case .audio:
						trackDuration = model.nowPlayingItem.trackTimeMillis.toInt
						trackTimePosition = PlayerObservableObject.audioPlayer.currentPlaybackTime.toInt
						timeRemain = trackDuration - trackTimePosition
					case .video:
						trackDuration = model.videoPlayer.trackDuration
						trackTimePosition = model.videoPlayer.trackTimePosition
						timeRemain = trackDuration - trackTimePosition
					}
				}
				.frame(height: Metric.trackTimeSliderHeight)

				HStack() {
					Text(trackTimePosition.toTime)
						.font(.caption2).bold()
						.foregroundColor( isDragging ? .white.opacity(0.9) : Color.lightGrayColor2)

					Spacer()

					Text("-" + timeRemain.toTime)
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
						timeRemain = trackDuration - trackTimePosition
					}
					.onEnded { _ in
						PlayerObservableObject.audioPlayer.currentPlaybackTime = TimeInterval(trackTimePosition)
						DispatchQueue.main.asyncAfter(deadline: .now() + scaleAnimationDuration) {
							isDragging = false
							timer = Timer.publish(every: 0, on: .main, in: .default).autoconnect()
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
		var trackTimePosition: Int = 0

		var body: some View {
			VStack {
				TimeSliderView()
			}
			.background(.secondary)
		}
	}

	static var previews: some View {
		TimeView()
	}
}
