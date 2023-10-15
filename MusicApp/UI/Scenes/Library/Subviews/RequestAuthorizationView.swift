//
//  RequestAuthorizationView.swift
//  MusicApp
//
//  Created by iMac on 14.10.2023.
//

import SwiftUI

struct RequestAuthorizationView: View {
   @Environment(\.openURL) private var openURL
   
   var body: some View {
      VStack(spacing: 2) {
         Spacer()
         
         Text("No Access to Your Library")
            .font(.title2).bold()
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.primary)
         
         Text("Allow access to your media library to add your favorite songs and playlists.")
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.secondary)
            .padding(.horizontal)
         
         Button {
            if let url = URL(string: UIApplication.openSettingsURLString) {
               openURL(url)
            }
         } label: {
            Text("Open Settings")
               .font(.title3)
               .bold()
               .frame(maxWidth:.infinity)
               .padding(.vertical, 8)
         }
         .tint(.accentColor)
         .padding(.horizontal, 50)
         .frame(maxWidth: .infinity)
         .buttonStyle(.borderedProminent)
         .padding(.top, 10)
         
         Spacer()
      }
   }
}
