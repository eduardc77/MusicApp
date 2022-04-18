//
//  ImagePlaceholderView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct ImagePlaceholderView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.secondary.opacity(0.2))
                .frame(width: 50, height: 50)
                .cornerRadius(5)
                .shadow(radius: 5)
            Image(systemName: "music.note")
                .foregroundColor(Color.secondary)
        }
    }
}

struct ImagePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholderView()
    }
}
