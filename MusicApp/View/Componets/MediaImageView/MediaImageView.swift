//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
    @StateObject private var mediaImageObservableObject: MediaImageObservableObject
    @Binding private var visibleSide: FlipViewSide
    @Binding var playing: Bool
    
    @State var animate: Bool = false
    
    private let imagePath: String?
    private var artworkImage: UIImage?
    private var sizeType: SizeType
    private var cornerRadius: CGFloat
    private var shadowProminence: ShadowProminence
    private var contentMode: ContentMode
    private var foregroundColor: Color

    @State private var shadow: (radius: CGFloat, xPosition: CGFloat, yPosition: CGFloat) = (0, 0, 0)
    
    init(imagePath: String? = nil, artworkImage: UIImage? = nil, sizeType: SizeType = .defaultSize, cornerRadius: CGFloat = Metric.defaultCornerRadius, shadowProminence: ShadowProminence = .none, contentMode: ContentMode = .fit, foregroundColor: Color = .secondary.opacity(0.1), visibleSide: Binding<FlipViewSide> = .constant(.front), playing: Binding<Bool> = .constant(false)) {
        _mediaImageObservableObject = StateObject(wrappedValue: MediaImageObservableObject())
        _visibleSide = visibleSide
        
        _playing = playing
        
        
        
        self.imagePath = imagePath
        self.artworkImage = artworkImage
        self.sizeType = sizeType
        self.cornerRadius = cornerRadius
        self.shadowProminence = shadowProminence
        self.contentMode = contentMode
        self.foregroundColor = foregroundColor
        
        
    }
    
    var body: some View {
        FlipView(visibleSide: visibleSide) {
            Group {
                if let uiImage = mediaImageObservableObject.image {
                    Image(uiImage: uiImage)
                        .resizable()
                } else if let artworkImage = artworkImage, let artwork = Image(uiImage: artworkImage) {
                    artwork
                        .resizable()
                }
                
                else {
                    ZStack {
                        Group {
                            switch sizeType {
                            case .artistRow:
                                Circle()
                                    .fill(foregroundColor)
                                    .frame(width: sizeType.size.width, height: sizeType.size.height)
                                    .cornerRadius(cornerRadius)
                                
                                    .overlay {
                                        Circle()
                                            .stroke(Color.secondary.opacity(0.8), lineWidth: 0.1)
                                    }
                                
                                Image(systemName: "music.mic")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.secondary)
                                    .frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2)
                            default:
                                Rectangle()
                                    .fill(foregroundColor)
                                    .frame(width: sizeType.size.width, height: sizeType.size.height)
                                    .cornerRadius(cornerRadius)
                                
                                    .overlay {
                                        RoundedRectangle(cornerRadius: cornerRadius)
                                            .stroke(Color.secondary.opacity(0.8), lineWidth: 0.1)
                                    }
                                
                                Image("music-note")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.secondary.opacity(0.3))
                                    .frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6)
                            }
                        }
                    }
                }
            }
            .aspectRatio(contentMode: contentMode)
            .frame(width: sizeType.size.width, height: sizeType.size.height)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadow.radius, x: shadow.xPosition, y: shadow.yPosition)
            
            .overlay {
                ZStack {
                    if playing {
                        
                        Color.gray.opacity(0.6)
                        
                        NowPlayingEqualizerBars(animating: $animate, color: .white)
                            .frame(width: 16, height: 8)
                            .onAppear {
                                animate.toggle()
                            }
                    }
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.secondary.opacity(0.6), lineWidth: 0.1)
                }
                
            }
            
        } back: {
            ZStack {
                Rectangle()
                    .fill(foregroundColor)
                    .frame(width: sizeType.size.width, height: sizeType.size.height)
                    .cornerRadius(cornerRadius)
                
                Image("music-note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.secondary.opacity(0.3))
                    .frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6)
            }
        }
        .contentShape(Rectangle())
        .animation(.flipCard, value: visibleSide)
        
        .onAppear {
            setupShadowProminence()
        }
        .task {
            guard let imagePath = imagePath else { return }
            await mediaImageObservableObject.fetchImage(from: imagePath)    
        }
    }
    
    func setupShadowProminence() {
        switch shadowProminence {
        case .none:
            shadow = (0, 0, 0)
        case .mild:
            shadow = (radius: 2, xPosition: 0, yPosition: 2)
        case .full:
            shadow = (radius: 16, xPosition: -6, yPosition: 6)
        }
    }
}

// MARK: - Types

extension MediaImageView {
    enum ShadowProminence: Int {
        case none = 0
        case mild = 2
        case full = 16
    }
}


//
//struct MediaImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaImageView(image: Image("p0"), size: Size(width: 333, height: 333))
//    }
//}
