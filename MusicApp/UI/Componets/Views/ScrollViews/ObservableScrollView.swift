//
//  ObservableScrollView.swift
//  MusicApp
//
//  Created by iMac on 15.10.2023.
//

import SwiftUI

struct ObservableScrollView<Content>: View where Content : View {
   let scrollSpace: Namespace.ID
   @Binding var scrollOffset: CGFloat
   let content: () -> Content
   
   init(scrollSpace: Namespace.ID,
        scrollOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content) {
      self.scrollSpace = scrollSpace
      _scrollOffset = scrollOffset
      self.content = content
   }
   
   var body: some View {
      ScrollView {
         content()
            .background(
               GeometryReader { geometry in
                  let offset = -geometry.frame(in: .named(scrollSpace)).origin.y
                  Color.clear
                     .preference(key: ScrollViewOffsetPreferenceKey.self,
                                 value: offset)
               })
      }
      .coordinateSpace(name: scrollSpace)
      .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
         scrollOffset = value
      }
   }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
   static var defaultValue = CGFloat.zero
   
   static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value += nextValue()
   }
}
