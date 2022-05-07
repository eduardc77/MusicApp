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
    
    @Binding private var songTimePosition: Int
    @State private var xOffset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var timeBegin: Int = 0
    @State private var timeRemain: Int = 0
    
    private var player: MPMusicPlayerController?
    private let songTime: Int
    
    init(playerObservableObject: PlayerObservableObject, songTime: Int, songTimePosition: Binding<Int>, player: MPMusicPlayerController) {
        self.playerObservableObject = playerObservableObject
        self.songTime = songTime
        self._songTimePosition = songTimePosition
        self.player = player
        
        _timeBegin = State(wrappedValue: $songTimePosition.wrappedValue)
        _timeRemain = State(initialValue: songTime - timeBegin)
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
                        .frame(width: CGFloat(songTimePosition) / CGFloat(songTime) * geometry.size.width, height: Metric.timeLineHeight)
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
                        .offset(x: CGFloat(songTimePosition) / CGFloat(songTime) * geometry.size.width - (isDragging ? Metric.largePoint / 2 : Metric.smallPoint / 2))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    guard player != nil else { return }
                                    
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
                                .onEnded { _ in
                                    isDragging = false
                                    player?.currentPlaybackTime = TimeInterval(songTimePosition)
                                }
                            
                        )
                        .animation(.linear(duration: 0.16), value: isDragging)
                }
                .onReceive(PlayerView.timer) { _ in
                    guard let currentPlaybackTime = player?.currentPlaybackTime else { return }
                    timeBegin = Int(currentPlaybackTime)
                    timeRemain = songTime - timeBegin
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
        @StateObject var playerObservableObject = PlayerObservableObject(player: MPMusicPlayerController.applicationMusicPlayer)
        @State var songTimePosition: Int = 0
        
        var body: some View {
            VStack {
                TimeSliderView(playerObservableObject: playerObservableObject, songTime: 215, songTimePosition: $songTimePosition, player: MPMusicPlayerController.applicationMusicPlayer)
            }
            .background(.gray)
        }
    }
    
    static var previews: some View {
        TimeView()
    }
}
