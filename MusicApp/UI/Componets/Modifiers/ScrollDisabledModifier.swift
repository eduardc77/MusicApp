//
//  ScrollDisabledModifier.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.08.2022.
//

import SwiftUI

struct ScrollDisabledModifier: ViewModifier {
   var value: Bool
   
   func body(content: Content) -> some View {
      if #available(iOS 16, *) {
         content
            .scrollDisabled(value)
      } else {
         content
      }
   }
}

extension View {
   func scrollingDisabled(_ value: Bool) -> some View {
      self.modifier(ScrollDisabledModifier(value: value))
   }
}
