//
//  CircleButtonStyle.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.01.2023.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
   var padding: CircleButtonPadding = .small
   var fadeOnPress = true
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .dynamicTypeSize(.large)
         .padding(padding.value)
         .background(configuration.isPressed && fadeOnPress ? Color.secondary.opacity(0.8) : Color.clear, in: Circle())
         .contentShape(Circle())
         .opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
         .scaleEffect(configuration.isPressed ? 0.86 : 1)
   }
}

enum CircleButtonPadding: Int {
   case small = 12
   case large = 24
   
   var value: CGFloat {
      CGFloat(self.rawValue)
   }
}

extension ButtonStyle where Self == CircleButtonStyle {
   static var circle: CircleButtonStyle {
      CircleButtonStyle()
   }
   
   static func circle(padding: CircleButtonPadding = .small, fadeOnPress: Bool = true) -> CircleButtonStyle {
      CircleButtonStyle(padding: padding, fadeOnPress: fadeOnPress)
   }
}
