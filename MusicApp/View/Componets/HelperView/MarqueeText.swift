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
    
    var animationSpeed: Double = 0.03
    var delayTime: Double = 3.33
    var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(text)
                .font(Font(font))
                .foregroundColor(.white)
                .offset(x: offset)
                .padding(.leading)
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
           
            // Stoping Animation exactly before the next text
            storedSize = textSize()
            text.append(baseText)
            
            // Calculating total seconds based on Text width
            let timing: Double = (animationSpeed * storedSize.width)
            
            // Delaying First Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: timing)) {
                    offset = -storedSize.width
                }
            }
        }
        // Repeating Marquee Effect with the help of Timer
        .onReceive(Timer.publish(every: ((animationSpeed * storedSize.width) + delayTime), on: .main, in: .default).autoconnect()) { _ in
            // Resetting offset to 0 for the looping effect
            offset = 0
            withAnimation(.linear(duration:(animationSpeed * storedSize.width))) {
                offset = -storedSize.width
            }
        }
    }
    
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
    }
}
