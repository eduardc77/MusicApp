//
//  MainButton.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 27.04.2022.
//

import SwiftUI

struct MainButton: View {
    var title: String
    var font: Font = .headline
    var image: Image?
    var spacing: CGFloat = 10
    var foregroundColor: Color = .appAccentColor
    var tint: Color = .secondary.opacity(0.16)
    var size: Size = Size(width: .infinity, height: 26)
    var cornerRadius: CGFloat = Metric.defaultCornerRadius
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                image
                
                Text(title)
            }
            .font(font)
            .frame(height: size.height)
            .frame(maxWidth: size.width)
        }
        
        .tint(tint)
        .foregroundColor(foregroundColor)
        .buttonStyle(.borderedProminent)
        .cornerRadius(cornerRadius)
    }
}


struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(title: "Button", image: Image(systemName: "shuffle"), action: {})
    }
}

