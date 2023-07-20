//
//  NavigationLinkRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct NavigationLinkRow<Content: View>: View {
   let text: String
   var destinationView: Content
   
   var body: some View {
      NavigationLink(destination: destinationView) {
         HStack {
            Text(text)
         }
      }
   }
}


// MARK: - Previews

struct NavigationLinkRow_Previews: PreviewProvider {
   static var previews: some View {
      NavigationLinkRow(text: "Notifications", destinationView: ProfileView())
   }
}
