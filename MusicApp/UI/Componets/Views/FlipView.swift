//
//  FlipView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 05.05.2022.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
   var visibleSide: FlipViewSide
   @ViewBuilder var front: Front
   @ViewBuilder var back: Back
   
   var body: some View {
      ZStack {
         front
            .modifier(FlipModifier(side: .front, visibleSide: visibleSide))
         back
            .modifier(FlipModifier(side: .back, visibleSide: visibleSide))
      }
   }
}

enum FlipViewSide {
   case front
   case back
   
   mutating func toggle() {
      self = self == .front ? .back : .front
   }
}

struct FlipModifier: AnimatableModifier {
   var side: FlipViewSide
   var flipProgress: Double
   
   init(side: FlipViewSide, visibleSide: FlipViewSide) {
      self.side = side
      self.flipProgress = visibleSide == .front ? 0 : 1
   }
   
   public var animatableData: Double {
      get { flipProgress }
      set { flipProgress = newValue }
   }
   
   var visible: Bool {
      switch side {
      case .front:
         return flipProgress <= 0.5
      case .back:
         return flipProgress > 0.5
      }
   }
   
   public func body(content: Content) -> some View {
      ZStack {
         content
            .opacity(visible ? 1 : 0)
            .accessibility(hidden: !visible)
      }
      .scaleEffect(x: scale, y: 1.0)
      .rotation3DEffect(.degrees(flipProgress * -180), axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 0.5)
   }
   
   var scale: CGFloat {
      switch side {
      case .front:
         return 1.0
      case .back:
         return -1.0
      }
   }
}


// MARK: - Previews

struct FlipView_Previews: PreviewProvider {
   struct FlipViewExample: View {
      @State var side: FlipViewSide = .front
      
      var body: some View {
         VStack {
            FlipView(visibleSide: side) {
               Text(verbatim: "Front Side")
                  .frame(width: 200, height: 200)
                  .background(.pink.opacity(0.8))
               
            } back: {
               Text(verbatim: "Back Side")
                  .frame(width: 200, height: 200)
                  .background(.purple.opacity(0.8))
            }
            .animation(.flipCard, value: side)
            
            Button { side.toggle() } label: {
               Label("Flip Card", systemImage: "square.stack.3d.forward.dottedline")
            }
         }
      }
   }
   
   static var previews: some View {
      FlipViewExample()
   }
}

