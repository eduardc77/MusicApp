//
//  VolumeSlider.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 26.04.2022.
//

import MediaPlayer
import SwiftUI
import AVKit

struct VolumeSlider: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let mpVolumeView = MPVolumeView(frame: .zero)
    mpVolumeView.setVolumeThumbImage(UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    
    // This is needed because of the deprecated 'showRouteButton' property of MPVolumeView.
    mpVolumeView.setValue(false, forKey: "showsRouteButton")
    
    return mpVolumeView
  }
  
  func updateUIView(_ view: UIView, context: Context) {}
}

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
