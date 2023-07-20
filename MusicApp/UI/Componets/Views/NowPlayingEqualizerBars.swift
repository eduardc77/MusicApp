//
//  NowPlayingEqualizerBars.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.05.2022.
//

import SwiftUI

struct NowPlayingEqualizerBars: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   @State var animating: Bool = false
   var color: Color = .appAccentColor
   var numberOfBars = 4
   var spacerWidthRatio: CGFloat = 0.6
   
   private var barWidthScaleFactor: CGFloat {
      1 / (CGFloat(numberOfBars) + CGFloat(numberOfBars - 1) * spacerWidthRatio)
   }
   
   var body: some View {
      GeometryReader { proxy in
         let barWidth = proxy.size.width * barWidthScaleFactor
         let spacerWidth = barWidth * spacerWidthRatio
         
         HStack(spacing: spacerWidth) {
            ForEach(0..<numberOfBars, id: \.self) { index in
               EqualizerBar(maxHeightFraction: animating ? 1 : 0.36, completion: animating ? 1 : 0)
                  .fill(color)
                  .frame(width: barWidth)
                  .animation(.ripple(index: index), value: animating)
            }
         }
         .clipped()
      }
      .onAppear { setupAnimation() }
      
      .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerPlaybackStateDidChange)) { _ in
         setupAnimation()
      }
   }
   
   private func setupAnimation() {
      animating = playerObservableObject.playbackState == .playing
   }
}

struct EqualizerBar: Shape {
   var minHeightFraction: CGFloat = 0.36
   var maxHeightFraction: CGFloat = 1
   var animatableData: CGFloat = 0
   
   init(maxHeightFraction: CGFloat, completion: CGFloat) {
      self.maxHeightFraction = maxHeightFraction
      self.animatableData = completion
   }
   
   func path(in rect: CGRect) -> Path {
      var path = Path()
      
      let heightFractionDelta = maxHeightFraction - minHeightFraction
      let heightFraction = minHeightFraction + heightFractionDelta * animatableData
      
      let rectHeight = rect.height * heightFraction
      let rectOrigin = CGPoint(x: rect.minX, y: rect.maxY - rectHeight)
      let rectSize = CGSize(width: rect.width, height: rectHeight)
      let barRect = CGRect(origin: rectOrigin, size: rectSize)
      
      path.addRect(barRect)
      
      return path
   }
}


// MARK: - Previews

struct NowPlayingEqualizerBars_Previews: PreviewProvider {
   struct NowPlayingEqualizerBarsExample: View {
      @State var animating: Bool = false
      
      var body: some View {
         VStack {
            Spacer()
            NowPlayingEqualizerBars()
               .frame(width: 40, height: 24)
            
            Spacer()
            
            Button { animating.toggle() } label: {
               Label("Animate", systemImage: "square.stack.3d.forward.dottedline")
            }
            Spacer()
         }
      }
   }
   
   static var previews: some View {
      NowPlayingEqualizerBarsExample()
   }
}
