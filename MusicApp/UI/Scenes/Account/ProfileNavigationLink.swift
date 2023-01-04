//
//  ProfileNavigationLink.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct ProfileNavigationLink: View {
  let username: String
  let email: String
  var image: Image = Image(systemName: "person.crop.circle")
  
  var body: some View {
    NavigationLink(destination: ProfileView()) {
      HStack {
        image
          .font(.system(size: 42))
          .padding(.leading, 2)
          .foregroundColor(.appAccentColor)
        
        VStack (alignment: .leading, spacing: 4) {
          Text(username)
          
          Text("View Profile")
            .font(.callout)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}


// MARK: - Previews

struct ProfileNavigationLink_Previews: PreviewProvider {
  static var previews: some View {
    ProfileNavigationLink(username: "John Appleseed", email: "john.appleseed@icloud.com")
  }
}
