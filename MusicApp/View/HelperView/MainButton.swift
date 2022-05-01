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
    var forgroundColor: Color = .appAccentColor
    var tint: Color = .secondary.opacity(0.16)
    var size: Size = Size(width: .infinity, height: 26)
    var action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            HStack {
                image
                    .font(.headline)
                
                Text(title)
                    .font(font)
                   
            }
            .frame(maxWidth: .infinity, maxHeight: size.height)
        }
        
        .tint(tint)
        .foregroundColor(forgroundColor)
        .buttonStyle(.borderedProminent)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(title: "Button", image: Image(systemName: "shuffle"), action: {})
    }
}