//
//  TimeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct TimeView: View {
    let songTime: Int
    @Binding var songTimePosition: Int

    @State var xOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0

    @State var isDragging = false

    @State var timeBegin: Int = 0
    @State var timeRemain: Int = 0

    init(songTime: Int, songTimePosition: Binding<Int>) {
        self._songTimePosition = songTimePosition
        self.songTime = songTime
        _timeBegin = State(wrappedValue: $songTimePosition.wrappedValue)
        _timeRemain = State(initialValue: songTime - timeBegin)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Capsule()
                        .fill(Color.secondary.opacity(0.2))
                        .frame(height: Metric.timeLineHeight)
                    Capsule()
                        .fill(Color.secondary)
                        .frame(width: CGFloat(songTimePosition) / CGFloat(songTime) * geometry.size.width, height: Metric.timeLineHeight)
                    Circle()
                        .fill(.white)
                        .frame(width: isDragging ? Metric.largePoint : Metric.smallPoint,
                               height: isDragging ? Metric.largePoint : Metric.smallPoint
                        )
                        .background {
                            Circle()
                                .fill(.primary)
                                .frame(width: Metric.largePoint, height: Metric.largePoint)
                                .opacity(0.01)

                        }
                        .offset(x: CGFloat(songTimePosition) / CGFloat(songTime) * geometry.size.width - (isDragging ? Metric.largePoint / 2 : Metric.smallPoint / 2))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                     isDragging = true

                                    if abs(value.translation.width) < 0.1 {
                                        lastOffset = CGFloat(songTimePosition) / CGFloat(songTime) * geometry.size.width
                                    }

                                    var sliderPos = max(0, lastOffset + value.translation.width)
                                    sliderPos = min(sliderPos, geometry.size.width)
                                    xOffset = sliderPos

                                    let sliderVal = sliderPos / geometry.size.width * 100
                                    songTimePosition = Int(sliderVal * CGFloat(songTime) / 100)

                                    timeBegin = songTimePosition
                                    timeRemain = songTime - timeBegin
                                }
                                .onEnded { _ in isDragging = false }
                            
                        ).animation(.linear(duration: 0.16), value: isDragging)
                }
                .frame(height: Metric.largePoint)

                HStack() {
                    Text(timeBegin.toTime())
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("-" + timeRemain.toTime())
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }.padding(.horizontal)
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(songTime: 215, songTimePosition: .constant(74))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}

// MARK: - Extensions
extension Int {
    func toTime() -> String {
        return String(format: "%1d:%02d", self / 60, self - self / 60 * 60)
    }
}

extension TimeView {
    enum Metric {
        static let largePoint: CGFloat = 32
        static let smallPoint: CGFloat = 6
        static let timeLineHeight: CGFloat = 3
    }
}
