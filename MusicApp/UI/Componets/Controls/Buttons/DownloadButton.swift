//
//  DownloadButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 12.01.2023.
//

import SwiftUI

struct DownloadButton: View {
   var font: Font = .body
   var foregroundColor: Color = .accentColor
   var backgroundColor: Color = Color.secondary.opacity(0.16)
   
   var action: () -> Void
   
   var body: some View {
      Button { action() } label: {
         Image(systemName: "arrow.down.circle.fill")
            .font(font)
            .foregroundStyle(foregroundColor, backgroundColor)
      }
   }
}
