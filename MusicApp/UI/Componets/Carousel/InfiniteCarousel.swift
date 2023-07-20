//
//  InfiniteCarousel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.01.2023.
//

import SwiftUI

struct InfiniteCarousel<Content: View>: View {
   
   enum ScrollingDirection {
      case left, right, up, down
      
      var axis: Axis.Set {
         switch self {
         case .left: return Axis.Set.horizontal
         case .right: return Axis.Set.horizontal
         case .up: return Axis.Set.vertical
         case .down: return Axis.Set.vertical
         }
      }
   }
   
   var animationDuration: Double = 40
   var animationDelay: Double = 0
   let scrollingDirection: ScrollingDirection
   let contentSize: CGSize
   @State var spacing: CGFloat
   var explicitText: Explicitness = .notExplicit
   @State private var offset: CGFloat = 0
   let content: (() -> Content)
   
   var body: some View {
      ScrollView(scrollingDirection.axis, showsIndicators: false) {
         switch scrollingDirection.axis {
         case .horizontal:
            HStack(spacing: 0) {
               content()
               content()
            }.offset(x: offset)
         case .vertical:
            VStack(spacing: 0) {
               content()
               content()
            }.offset(x: 0, y: offset)
         default:
            EmptyView()
         }
      }
      .disabled(true)
      .onAppear {
         if explicitText == .explicit { spacing += 22 }
         if offset == 0 { initOffset() }
         
         withAnimation(.linear(duration: animationDuration).delay(animationDelay).repeatForever(autoreverses: false)) {
            updateOffset()
         }
      }
   }
   
   private func initOffset() {
      switch scrollingDirection {
      case .left:
         offset = 0
      case .right:
         offset = -contentSize.width
      case .up:
         offset = 0
      case .down:
         offset = -contentSize.height
      }
   }
   
   private func updateOffset() {
      switch scrollingDirection {
      case .left:
         offset = -contentSize.width - spacing
      case .right:
         offset = 0
      case .up:
         offset = -contentSize.height
      case .down:
         offset = 0
      }
   }
}
