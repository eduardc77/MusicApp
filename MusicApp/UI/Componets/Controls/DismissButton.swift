//
//  DismissButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct DismissButton: View {
  var title: String
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    Button {
      presentationMode.wrappedValue.dismiss()
    } label: {
      Text("Done").bold()
    }
  }
}


// MARK: - Previews

struct DismissButton_Previews: PreviewProvider {
  static var previews: some View {
    DismissButton(title: "Cancel")
  }
}
