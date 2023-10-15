//
//  UIScreen+displayCornerRadius.swift
//  MusicApp
//
//  Created by iMac on 15.10.2023.
//

import SwiftUI

extension UIScreen {
   public var displayCornerRadius: CGFloat {
      guard let cornerRadius = self.value(forKey:"_displayCornerRadius") as? CGFloat else {
         return 0
      }
      return cornerRadius
   }
}
