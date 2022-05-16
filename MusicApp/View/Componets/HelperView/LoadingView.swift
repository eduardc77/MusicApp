//
//  LoadingView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 3) {
            ProgressView()
            Text("LOADING")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

