//
//  TimeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct TimeSliderView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   
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
         VStack(spacing: 8) {
            Spacer()
            ZStack(alignment: .leading) {
               Rectangle()
                  .fill(Color.lightGrayColor2)
               
               Rectangle()
                  .fill( isDragging ? .white : Color.lightGrayColor)
                  .frame(width: (trackDuration != 0) ? (CGFloat(trackTimePosition) / CGFloat(trackDuration) * geometry.size.width) : CGFloat.zero)
            }
            .frame(height: isDragging ? Metric.timeLineHeight * 2 : Metric.timeLineHeight)
            .clipShape(Capsule(style: .continuous))
            
            .onReceive(timer) { _ in
               switch PlayerModel.playerType {
                  case .audio:
                       trackDuration = playerModel.nowPlayingItem?.trackTimeMillis.toInt ?? 0
                       trackTimePosition = PlayerModel.audioPlayer?.currentPlaybackTime.toInt ?? 0
                     timeRemain = trackDuration - trackTimePosition
                     
                  case .video:
                     trackDuration = PlayerModel.videoPlayer.trackDuration
                     trackTimePosition = PlayerModel.videoPlayer.trackTimePosition
                     timeRemain = trackDuration - trackTimePosition
               }
            }
            
            HStack {
               Text(trackTimePosition.toTime)
                  .font(.caption2).bold()
                  .foregroundStyle( isDragging ? .white : Color.lightGrayColor2)
                  .frame(maxWidth: 80, alignment: .leading)
               
               Spacer()
               
               LosslessLogo().offset(y: 1.6)
               
               Spacer()
               
               Text("-" + timeRemain.toTime)
                  .font(.caption2).bold()
                  .foregroundStyle( isDragging ? .white : Color.lightGrayColor2)
                  .frame(maxWidth: 80, alignment: .trailing)
            }
            Spacer()
         }
         .contentShape(Rectangle())
         
         .gesture(
            DragGesture(minimumDistance: 0)
               .onChanged { value in
                  isDragging = true
                  stopTimer()
                  
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
                  PlayerModel.audioPlayer?.currentPlaybackTime = TimeInterval(trackTimePosition)
                  DispatchQueue.main.asyncAfter(deadline: .now() + scaleAnimationDuration) {
                     isDragging = false
                     timer = Timer.publish(every: 0, on: .main, in: .default).autoconnect()
                  }
               }
         )
      }
      .padding(.horizontal)
      .frame(height: Metric.trackTimeSliderHeight)
      .scaleEffect(x: isDragging ? 1.06 : 1, y: isDragging ? 1.16 : 1)
      .animation(.smooth, value: isDragging)
      
      .onDisappear {
         stopTimer()
      }
   }
   
   private func stopTimer() {
      timer.upstream.connect().cancel()
   }
}


// MARK: - Previews

struct TimeView_Previews: PreviewProvider {
   struct TimeView: View {
      var body: some View {
         TimeSliderView()
            .padding()
            .background(.bar)
            .environmentObject(PlayerModel())
      }
   }
   
   static var previews: some View {
      TimeView()
   }
}
