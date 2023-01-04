//
//  MediaItemName.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 22.05.2022.
//

import SwiftUI

struct MediaItemName: View {
  var name: String
  var explicitness: Explicitness = .notExplicit
  var font: Font = .body
  var imageFont: Font = .caption
  var foregroundColor: Color = .primary
  var lineLimit: Int = 1
  var spacing: CGFloat = 3
  
  var body: some View {
    switch explicitness {
    case .notExplicit, .cleaned:
      Text(name)
        .font(font)
        .foregroundColor(foregroundColor)
        .lineLimit(lineLimit)
    default:
      HStack(spacing: spacing) {
        Text(name)
          .font(font)
          .foregroundColor(foregroundColor)
          .lineLimit(lineLimit)
        
        Image(systemName: "e.square.fill")
          .font(imageFont)
          .foregroundColor(.secondary)
      }
    }
  }
}

enum Explicitness: String {
  case explicit
  case cleaned
  case notExplicit
}


