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
  
  var color: Color = .white.opacity(0.9)
  var animationSpeed: Double = 0.03
  var delayTime: Double = 3.33
  var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
  
  var body: some View {
    if text.size(withFont: font).width > Metric.screenWidth / 1.6 {
      ScrollView(.horizontal, showsIndicators: false) {
        Text(text)
          .font(Font(font))
          .foregroundColor(color)
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
      MediaItemName(name: text, explicitness: explicitness, font: Font(font), imageFont: Font(UIFont.boldSystemFont(ofSize: 16)), foregroundColor: color, spacing: 4)
        .padding(.leading, 30)
    }
  }
}


// MARK: - Previews

struct MarqueeText_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			Color(.secondaryLabel)

			MarqueeText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
		}
	}
}
