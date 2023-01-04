//
//  ScrollDismissesKeyboard.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.08.2022.
//

import SwiftUI

struct ScrollDismissesKeyboard: ViewModifier {
  func body(content: Content) -> some View {
    if #available(iOS 16, *) {
      content
        .scrollDismissesKeyboard(.immediately)
    } else {
      content
    }
  }
}

extension View {
  func dismissKeyboardOnScroll() -> some View {
    self.modifier(ScrollDismissesKeyboard())
  }
}
