//
//  FavoriteButton.swift
//  MusicApp
//
//  Created by iMac on 15.10.2023.
//

import SwiftUI

struct FavoriteButton: View {
   var font: Font = .headline
   var foregroundColor: Color = .accentColor
   var backgroundColor: Color = .secondaryButtonBackgroundColor
   
   @Binding var isFavorite: Bool
   
   var action: () -> Void
   
   var body: some View {
      Button {
         action()
         isFavorite.toggle()
      } label: {
         Image(systemName: "star")
            .imageScale(.medium)
            .font(font)
            .symbolVariant(isFavorite ? .fill : .none)
            .contentTransition(.symbolEffect(isFavorite ? .replace.upUp : .replace.downUp))
            .padding(3)
            .background(in: .circle)
      }
      .buttonStyle(.plain)
      .buttonBorderShape(.circle)
      .foregroundStyle(isFavorite ? backgroundColor : foregroundColor)
      .backgroundStyle(isFavorite ? foregroundColor : backgroundColor)
      .accessibilityLabel("Favorite")
      .animation(.default, value: isFavorite)
   }
}
