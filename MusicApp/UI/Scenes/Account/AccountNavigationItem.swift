//
//  AccountNavigationItem.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import SwiftUI

struct AccountNavigationItem: View {
   @State private var showAccount = false
   
   var body: some View {
      Button { showAccount.toggle() } label: {
         Image(systemName: "person.crop.circle")
            .resizable()
            .font(.title2)
      }
      
      .sheet(isPresented: $showAccount) {
         AccountView()
      }
   }
}
