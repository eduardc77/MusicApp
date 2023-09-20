//
//  ParallaxHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct ParallaxHeaderView<Content: View, CoordinateSpace: Hashable>: View {
   private let coordinateSpace: CoordinateSpace
   private let height: CGFloat
   private let content: () -> Content
   
   init(
      coordinateSpace: CoordinateSpace,
      height: CGFloat,
      @ViewBuilder _ content: @escaping () -> Content
   ) {
      self.content = content
      self.coordinateSpace = coordinateSpace
      self.height = height
   }
   
   var body: some View {
      GeometryReader { proxy in
         let offset = offset(for: proxy)
         let heightModifier = heightModifier(for: proxy)

         content()
            .frame(width: proxy.size.width, height: proxy.size.height + heightModifier)
            .offset(y: offset)
      }
      .frame(height: height)
   }
   
   private func offset(for proxy: GeometryProxy) -> CGFloat {
      let frame = proxy.frame(in: .named(coordinateSpace))
      if frame.minY < 0 {
         return -frame.minY * 0.85
      }
      return -frame.minY
   }
   
   private func heightModifier(for proxy: GeometryProxy) -> CGFloat {
      let frame = proxy.frame(in: .named(coordinateSpace))
      return max(0, frame.minY)
   }
}


// MARK: - Previews

struct MediaPreviewHeader_Previews: PreviewProvider {
   struct MediaPreviewHeaderExample: View {
      let coordinateSpace: CoordinateSpace = CoordinateSpace.local
      @State var playing: Bool = false
      
      var body: some View {
         ScrollView {
            ParallaxHeaderView(
               coordinateSpace: coordinateSpace,
               height: 400
            ) {
               MediaImageView(imagePath: musicPlaylists2.first?.artworkPath ?? "".resizedPath(size: 400))
            }
            
            Rectangle()
               .fill(.indigo)
               .frame(height: 1000)
         }
         .coordinateSpace(name: coordinateSpace)
      }
   }
   
   static var previews: some View {
      MediaPreviewHeaderExample()
   }
}
