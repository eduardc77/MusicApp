//
//  LosslessLogo.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 10.01.2023.
//

import SwiftUI

struct LosslessLogo: View {
   var bordered: Bool = true
   var color: Color = .lightGrayColor2
   
   var body: some View {
      HStack(spacing: 3) {
         Image("lossless-logo")
            .resizable()
            .scaledToFit()
            .frame(width: 18, height: 16)
         
         Text("Lossless")
            .font(.system(size: 11, weight: .medium))
      }
      .foregroundStyle(color)
      .padding(.horizontal, bordered ? 6.6 : 0)
      .padding(.vertical, bordered ? 1 : 0)
      .background(bordered ? RoundedRectangle(cornerRadius: 6, style: .continuous).foregroundStyle(Color.lightGrayColor3) : nil)
   }
}


// MARK: - Previews

struct LosslessLogo_Previews: PreviewProvider {
   static var previews: some View {
      LosslessLogo()
   }
}
