//
//  VolumeView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct VolumeView: View {
    @State var volume: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.secondary)
                    .padding(.leading)
                
                Slider(value: $volume)
                    .accentColor(.secondary)
                    .controlSize(.mini)
                
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }.padding(.top)
            
            BottomToolbar()
        }
    }
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}

extension VolumeView {
    enum Metric {
        static let regularSpacing: CGFloat = 16
        static let buttonsSpacing: CGFloat = 70
    }
}



//struct VolumeSlider: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//
//
//        let view = MPVolumeView(frame: .zero)
//        view.setVolumeThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
//        view.showsRouteButton = false
//        view.tintColor = .white
//        return view
//    }
//
//    func updateUIView(_ view: UIView, context: Context) {
//
//    }
//}
