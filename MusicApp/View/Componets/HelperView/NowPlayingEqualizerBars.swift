//
//  NowPlayingEqualizerBars.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 03.05.2022.
//

import SwiftUI

struct NowPlayingEqualizerBars: View {
    @Binding var animating: Bool
    
    static let numberOfBars = 4
    static let spacerWidthRatio: CGFloat = 0.6
    
    private let barWidthScaleFactor = 1 / ( CGFloat(NowPlayingEqualizerBars.numberOfBars) + CGFloat(NowPlayingEqualizerBars.numberOfBars - 1) * NowPlayingEqualizerBars.spacerWidthRatio)
    
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            let barWidth = geo.size.width * barWidthScaleFactor
            let spacerWidth = barWidth * NowPlayingEqualizerBars.spacerWidthRatio
            
            HStack(spacing: spacerWidth) {
                ForEach(0..<NowPlayingEqualizerBars.numberOfBars, id: \.self) { index in
                    EqualizerBar(completion: animating ? 1 : 0)
                        .fill(Color.appAccentColor)
                        .frame(width: barWidth)
                        .animation(.ripple(index: index), value: animating)
                }
            }
            .clipped()
        }
    }
}

struct EqualizerBar: Shape {
    let minHeightFraction: CGFloat = 0.4
    let maxHeightFraction: CGFloat = 1
    var animatableData: CGFloat
    
    init(completion: CGFloat) {
        self.animatableData = completion
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let heightFractionDelta = maxHeightFraction - minHeightFraction
        let heightFraction = minHeightFraction + heightFractionDelta * animatableData
        
        let rectHeight = rect.height * heightFraction
        let rectOrigin = CGPoint(x: rect.minX, y: rect.maxY - rectHeight)
        let rectSize = CGSize(width: rect.width, height: rectHeight)
        let barRect = CGRect(origin: rectOrigin, size: rectSize)
        
        path.addRect(barRect)
        
        return path
    }
}

struct NowPlayingEqualizerBars_Previews: PreviewProvider {
    struct NowPlayingEqualizerBarsExample: View {
        @State var animating: Bool = false
        
        var body: some View {
            VStack {
                Spacer()
                NowPlayingEqualizerBars(animating: $animating)
                    .frame(width: 40, height: 24)
                
                Spacer()
                
                Button { animating.toggle() } label: {
                    Label("Animate", systemImage: "square.stack.3d.forward.dottedline")
                }
                Spacer()
            }
        }
    }
    
    static var previews: some View {
        NowPlayingEqualizerBarsExample()
    }
}
