//
//  MarqueeText.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import SwiftUI

struct MarqueeText: View {
    @State var text: String
    @State var storedSize: CGSize = .zero
    @State var offset: CGFloat = 0
    var explicitness: Explicitness = .notExplicit
    
    var animationSpeed: Double = 0.03
    var delayTime: Double = 3.33
    var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
    
    var body: some View {
        if text.size(withFont: font).width > Metric.screenWidth / 1.6 {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(text)
                    .font(Font(font))
                    .foregroundColor(.white.opacity(0.9))
                    .offset(x: offset)
                    .padding(.leading, 24)
            }
            .mask {
                HStack(spacing: 0) {
                    Spacer()
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.6), Color.black]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .frame(width: 30)
                    
                    LinearGradient(gradient: Gradient(colors: [.black]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    
                    LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.6), .black].reversed()), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .frame(width: 30)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .disabled(true)
            
            .onAppear {
                let baseText = text
                
                (1...10).forEach { _ in
                    text.append(" ")
                }
               
                storedSize = text.size(withFont: font)
                text.append(baseText)
                
                withAnimation(
                    .linear(duration:(animationSpeed * storedSize.width))
                    .delay(delayTime)
                    .repeatForever(autoreverses: false)
                ) {
                    offset = -storedSize.width
                }
            }
            
            .padding(.leading, 6)
        } else {
            MediaItemName(name: text, explicitness: explicitness, font: Font(font), imageFont: Font(UIFont.boldSystemFont(ofSize: 16)), foregroundColor: .white.opacity(0.9), spacing: 6)
                .padding(.leading, 30)
        }
    }
}
