//
//  SnappingScrollView.swift
//  MusicApp
//
//  Created by iMac on 16.10.2023.
//

import SwiftUI

struct SnappingScrollView<Content>: View where Content : View {
   
   @StateObject private var delegate = SnappingScrollViewDelegate()
   @State private var frame: CGRect? = nil
   
   let scrollSpace: Namespace.ID
   @Binding var scrollOffset: CGFloat
   
   private var content: () -> Content
   
   init(
      scrollSpace: Namespace.ID,
      scrollOffset: Binding<CGFloat>,
      @ViewBuilder content: @escaping () -> Content)
   {
      self.scrollSpace = scrollSpace
      _scrollOffset = scrollOffset
      self.content = content
   }
   
   var body: some View {
      ScrollView {
         content()
            .environment(\.scrollViewFrame, frame)
            .background(
               GeometryReader { geometry in
                  let offset = -geometry.frame(in: .named(scrollSpace)).origin.y
                  Color.clear
                     .preference(key: ScrollViewOffsetPreferenceKey.self,
                                 value: offset)
               }
                  .hidden()
            )
         
            .backgroundPreferenceValue(AnchorsKey.self) { anchors in
               GeometryReader { geometry in
                  let frames = anchors.map { geometry[$0] }
                  
                  Color.clear
                     .onAppear { delegate.frames = frames }
                     .onChange(of: frames) { _, newValue in
                        delegate.frames = newValue
                     }
               }
               .hidden()
            }
            .transformPreference(AnchorsKey.self) { $0 = AnchorsKey.defaultValue }
            .background(UIScrollViewBridge(delegate: delegate))
      }
      .background(
         GeometryReader { geometry in
            Color.clear
               .onAppear {
                  DispatchQueue.main.async {
                     if frame == nil {
                        frame = geometry.frame(in: .global)
                     }
                  }
               }
               .onChange(of: geometry.frame(in: .global)) { _, newValue in
                  frame = newValue
               }
         }
            .ignoresSafeArea()
            .hidden()
      )
      
      .coordinateSpace(name: scrollSpace)
      .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
         scrollOffset = value
      }
   }
}

internal struct UIScrollViewBridge: UIViewRepresentable {
   var delegate: UIScrollViewDelegate
   
   func makeUIView(context: Context) -> UIView {
      let view = UIView()
      view.isHidden = true
      view.isUserInteractionEnabled = false
      return view
   }
   
   func updateUIView(_ uiView: UIView, context: Context) {
      DispatchQueue.main.async {
         if let scrollView = uiView.parentScrollView() {
            scrollView.decelerationRate = .normal
            scrollView.delegate = delegate
         }
      }
   }
}

private extension UIView {
   func parentScrollView() -> UIScrollView? {
      if let scrollView = self as? UIScrollView {
         return scrollView
      }
      
      if let superview = superview {
         for subview in superview.subviews {
            if subview != self, let scrollView = subview as? UIScrollView {
               return scrollView
            }
         }
         
         if let scrollView = superview.parentScrollView() {
            return scrollView
         }
      }
      
      return nil
   }
}


