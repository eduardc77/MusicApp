//
//  RowButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct RowButton: View {
  @State var isPresented = false
  
  let rowTitle: String
  var navigationTitle: String = ""
  
  var body: some View {
    Button { isPresented = true } label: {
      Text(rowTitle)
    }
    .sheet(isPresented: self.$isPresented) {
      DefaultView(title: navigationTitle.isEmpty ? rowTitle : navigationTitle)
    }
  }
}


// MARK: - Previews

struct RowButton_Previews: PreviewProvider {
  static var previews: some View {
    RowButton(isPresented: false, rowTitle: "Account Settings")
  }
}
