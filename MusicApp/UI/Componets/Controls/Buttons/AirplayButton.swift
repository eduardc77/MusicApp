//
//  AirplayButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 26.04.2022.
//

import SwiftUI
import AVKit

struct AirplayButton: UIViewRepresentable {
   var playerType: PlayerType = .audio
   
   func makeUIView(context: Context) -> UIView {
      let airplayPickerView = AVRoutePickerView(frame: .zero)
      
      airplayPickerView.tintColor = playerType == .audio ? UIColor.init(white: 1, alpha: 0.6) : UIColor(named: ("AccentColor"))
      airplayPickerView.activeTintColor = UIColor(named: ("AccentColor"))
      
      return airplayPickerView
   }
   
   func updateUIView(_ view: UIView, context: Context) {}
}
