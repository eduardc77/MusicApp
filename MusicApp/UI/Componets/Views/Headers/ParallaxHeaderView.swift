//
//  ParallaxHeaderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct ParallaxHeaderView<Content: View>: View {
   private let coordinateSpace: Namespace.ID
   private let height: CGFloat
   private let content: () -> Content
   
   init(
      coordinateSpace: Namespace.ID,
      height: CGFloat,
      @ViewBuilder _ content: @escaping () -> Content
   ) {
      self.coordinateSpace = coordinateSpace
      self.height = height
      self.content = content
   }
   
   var body: some View {
      GeometryReader { proxy in
         let offset = offset(for: proxy)
         let heightModifier = heightModifier(for: proxy)

         content()
            .frame(
               width: proxy.size.width,
               height: proxy.size.height + heightModifier
            )
            .offset(y: offset)
      }
      .frame(height: height)
   }
   
   private func offset(for proxy: GeometryProxy) -> CGFloat {
      let frame = proxy.frame(in: .named(coordinateSpace))
      if frame.origin.y < 0 {
         return -frame.origin.y * 0.8
      }
      return -frame.origin.y
   }
   
   private func heightModifier(for proxy: GeometryProxy) -> CGFloat {
      let frame = proxy.frame(in: .named(coordinateSpace))
      return max(0, frame.origin.y)
   }
}



// MARK: - Previews

struct MediaPreviewHeader_Previews: PreviewProvider {
   struct MediaPreviewHeaderExample: View {
      @Namespace var scrollSpace
      @State var playing: Bool = false
      
      var body: some View {
         ScrollView {
            ParallaxHeaderView(
               coordinateSpace: scrollSpace,
               height: Metric.mediaPreviewHeaderHeight
            ) {
               MediaImageViewContainer(imagePath: musicPlaylists2.first?.artworkPath ?? "".resizedPath(size: Int(Metric.mediaPreviewHeaderHeight)))
            }
            
            Rectangle()
               .fill(.indigo)
               .frame(height: 1000)
         }
         .coordinateSpace(name: scrollSpace)
         .ignoresSafeArea()
      }
   }
   
   static var previews: some View {
      MediaPreviewHeaderExample()
   }
}
