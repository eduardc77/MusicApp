//
//  View+HideKeyboard.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 27.04.2022.
//

import SwiftUI

extension View {
   func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
}
