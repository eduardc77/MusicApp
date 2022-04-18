//
//  BottomToolbar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct BottomToolbar: View {
    var body: some View {
        HStack(spacing: Metric.buttonsSpacing) {
            Button(action: {}) {
                Image(systemName: "quote.bubble")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Button(action: {}) {
                Image(systemName: "airplayaudio")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Button(action: {}) {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        }
        .padding()
    }
}

struct BottomToolBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbar()
    }
}

extension BottomToolbar {
    enum Metric {
        static let buttonsSpacing: CGFloat = 70
    }
}
