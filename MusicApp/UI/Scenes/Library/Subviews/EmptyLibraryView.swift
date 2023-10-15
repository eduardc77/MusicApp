//
//  EmptyLibraryView.swift
//  MusicApp
//
//  Created by iMac on 14.10.2023.
//

import SwiftUI

struct EmptyLibraryView: View {
   @Binding var tabSelection: Tab
   
   var body: some View {
      VStack {
         Spacer()
         
         Text("Add Music to Your Library")
            .font(.title2).bold()
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.primary)
         
         Text("Browse millions of songs and collect your favorites here.")
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.secondary)
            .padding(.horizontal)
         
         Button { tabSelection = .browse } label: {
            Text("Browse Apple Music")
               .font(.title3).bold()
               .frame(maxWidth:.infinity)
               .padding(.vertical, 8)
            
         }
         .tint(.accentColor)
         .padding(.horizontal, 50)
         .frame(maxWidth: .infinity)
         .buttonStyle(.borderedProminent)
         
         Spacer()
      }
   }
}
