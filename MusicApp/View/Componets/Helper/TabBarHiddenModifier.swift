//
//  TabbarHiddenModifier.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.08.2022.
//

import SwiftUI

struct TabBarHiddenModifier: ViewModifier {
  var value: Visibility
  
  func body(content: Content) -> some View {
    if #available(iOS 16, *) {
      content
        .toolbar(value, for: .tabBar)
    } else {
      content
    }
  }
}

extension View {
  func tabBarHidden(_ value: Visibility) -> some View {
    self.modifier(TabBarHiddenModifier(value: value))
  }
}
