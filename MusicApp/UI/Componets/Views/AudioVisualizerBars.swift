//
//  NowPlayingEqualizerBars.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.05.2022.
//

import SwiftUI

struct AudioVisualizerBars: View {
   @EnvironmentObject private var playerModel: PlayerModel
   var size: Size = Size(width: 16, height: 16)
   var spacing = 1.5
   var numberOfBars = 5
   var color: Color = .accentColor
   @State var animating: Bool = false
   
   var body: some View {
      HStack(spacing: spacing) {
         ForEach(0..<numberOfBars, id: \.self) { index in
            bar(low: animating ? Double.random(in: 0.1...0.4) : 0.1, high: Double.random(in: 0.5...1.0))
               .animation(animation(duration: Double.random(in: 0.4...0.6)).speed(Double.random(in: 1.0...1.3)), value: animating)
         }.onAppear(perform: setAnimation)
      }
      .frame(width: size.width, height: size.height)
      
      .onChange(of: playerModel.playbackState) { oldValue, newValue in
         animating.toggle()
      }
   }
   
   private func bar(low: CGFloat = 0.2, high: CGFloat = 1.0) -> some View {
      RoundedRectangle(cornerRadius: 3)
         .fill(color)
         .frame(height: (animating ? high : low) * (size.height ?? 16))
      // Uncomment for old style animation.
      //.frame(height: size.height ?? 16 + low, alignment: .bottom)

   }
   
   private func animation(duration: TimeInterval) -> Animation {
      return animating ? .easeInOut(duration: duration).repeatForever(autoreverses: true) : .easeOut(duration: duration)
   }
   
   private func setAnimation() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
         animating = playerModel.isPlaying
      }
   }
}


// MARK: - Previews

struct AudioVisualizerBars_Previews: PreviewProvider {
   struct AudioVisualizerBarsExample: View {
      
      var body: some View {
         AudioVisualizerBars(size: Size(width: 60, height: 60), spacing: 6)
      }
   }
   
   static var previews: some View {
      AudioVisualizerBarsExample()
         .environmentObject(PlayerModel())
   }
}

//struct AnimatedVisualizer: Shape {
//  let audioSamples: [CGFloat]
//
//  func path(in rect: CGRect) -> Path {
//    var path = Path()
//
//    let height = rect.height
//    let width = rect.width / CGFloat(audioSamples.count)
//
//    for i in 0 ..< audioSamples.count {
//      let x = width * CGFloat(i)
//      let y = CGFloat(audioSamples[i]) * height
//
//      path.addRect(CGRect(x: x, y: 0, width: width, height: y))
//    }
//
//    return path
//  }
//}
//
//struct ContentView: View {
//  @State private var audioSamples: [CGFloat] = [0.2, 0.5, 0.8, 0.3, 0.6, 0.9, 0.4, 0.4, 0.4, 0.4]
//
//  var body: some View {
//    ZStack {
//      AnimatedVisualizer(audioSamples: audioSamples)
//        .fill(Color.red)
//        .opacity(0.8)
//        .animation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true), value: audioSamples)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//    .onAppear {
//      Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
//        self.audioSamples = self.generateAudioSamples()
//      }
//    }
//  }
//
//  func generateAudioSamples() -> [CGFloat] {
//    var samples: [CGFloat] = []
//    for _ in 0...10 {
//      samples.append(CGFloat.random(in: 0...1))
//    }
//    return samples
//  }
//}
