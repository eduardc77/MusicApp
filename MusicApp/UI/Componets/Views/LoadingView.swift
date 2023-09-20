//
//  LoadingView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI

struct LoadingView: View {
   var title: String = "LOADING"
   
   var body: some View {
      VStack(spacing: 3) {
         ProgressView()
         
         Text(title)
            .font(.footnote)
            .foregroundStyle(Color.secondary)
      }
   }
}


// MARK: - Previews

struct LoadingView_Previews: PreviewProvider {
   static var previews: some View {
      LoadingView()
   }
}
