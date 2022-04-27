//
//  VolumeSlider.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 26.04.2022.
//

import MediaPlayer
import SwiftUI

struct VolumeSlider: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = MPVolumeView(frame: .zero)
        view.setVolumeThumbImage(UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        view.showsRouteButton = false
        
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {}
}
