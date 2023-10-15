//
//  ToolbarButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 12.01.2023.
//

import SwiftUI

struct ToolbarButton: View {
   var title: String
   var iconName: String
   var font: Font = .body
   var foregroundColor: Color = .accentColor
   var backgroundColor: Color = .secondaryButtonBackgroundColor
   
   var action: () -> Void
   
   var body: some View {
      Button {
         action()
      } label: {
         Image(systemName: iconName)
            .font(font)
            .symbolVariant(.circle.fill)
            .foregroundStyle(foregroundColor, backgroundColor)
      }
      .buttonStyle(.plain)
      .buttonBorderShape(.circle)
      .accessibilityLabel(title)
   }
}
