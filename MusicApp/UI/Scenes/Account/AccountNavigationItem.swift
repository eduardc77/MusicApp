//
//  AccountNavigationItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import SwiftUI

struct AccountNavigationItem: View {
   @State private var showingProfile = false
   
   var body: some View {
      Button { showingProfile.toggle() } label: {
         Image(systemName: "person.crop.circle")
            .font(.title2)
      }
      
      .sheet(isPresented: $showingProfile) {
         AccountView()
      }
   }
}
