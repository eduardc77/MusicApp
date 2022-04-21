//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerView: View {
    @Binding var expand: Bool
    @State var songTimePosition: Int = 0
    @State var volume: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var isPlaying = true
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            VStack {
                Capsule()
                    .frame(width: expand ? Metric.capsuleWidth : 0, height: expand ? Metric.capsuleHeight : 0)
                    .opacity(expand ? 1 : 0)
                    .padding(.top, expand ? 18 : 0)
                    .padding(.vertical, expand ? 30 : 0)
                
                // mini Player
                HStack() {
                    if expand { Spacer() }
                    
                    MediaImageView(image: Image("elton"), size: (width: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize, height: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize), cornerRadius: expand ? 20 : 6)
                    
                    // Or PlaceholderImage
                    // MediaImageView(size: (width: expand ? height : Metric.imageSize, height: expand ? height : Metric.imageSize), cornerRadius: expand ? 20 : 6)
                    
                    if !expand {
                        Text(ExampleMusic.songName)  // ?? Text("Not Playing")
                            .matchedGeometryEffect(id: "MediaTitle", in: animation, properties: .position)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    
                    if !expand {
                        HStack {
                            Button(action: {
                                isPlaying.toggle()
                            },
                                   label: {
                                isPlaying ?
                                Image(systemName: "play.fill")
                                    .matchedGeometryEffect(id: "Play", in: animation, properties: .position)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                                :
                                Image(systemName: "pause.fill")
                                    .matchedGeometryEffect(id: "Pause", in: animation, properties: .position)
                                    .font(.title)
                                    .foregroundColor(.primary)
                            }
                            )
                            .padding(.trailing)
                            
                            Button(action: {},
                                   label: {
                                Image(systemName: "forward.fill")
                                    .matchedGeometryEffect(id: "Forward", in: animation, properties: .position)
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }
                            )
                        }
                    }
                }
            }
            //            .frame(height: expand ? UIScreen.main.bounds.height / 2 :  Metric.playerHeight)
            .padding()
            
            // full screen Player
            VStack() {
                HStack {
                    VStack(alignment: .leading) {
                        Text(ExampleMusic.songName)
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "MediaTitle", in: animation, properties: .position)
                        Text(ExampleMusic.songArtist)
                            .foregroundColor(.secondary)
                            .font(.title3)
                    }
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white, .gray.opacity(0.3))
                    }
                }
                .padding(.horizontal)
                
                TimeView(songTime: ExampleMusic.songTime, songTimePosition: $songTimePosition)
                
                PlayerButtonsView(isPlaying: $isPlaying, animation: animation)
                
                VolumeView()
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : Metric.playerHeight)
        .background(
            VStack(spacing: 0) {
                if expand {
                    ZStack {
                        BlurView()
                        
                        LinearGradient(
                            gradient: Gradient(colors: [.pink.opacity(0.6), .blue.opacity(0.6), .secondary]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading)
                    }
                } else {
                    BlurView()
                    Divider()
                }
            }
                .onTapGesture {
                    withAnimation(.spring()) {
                        expand = true
                    }
                }
        )
        .cornerRadius(expand ? 36 : 0)
        .offset(y: expand ? 0 : Metric.yOffset)
        .offset(y: offset)
        .gesture(DragGesture()
            .onChanged(onChanged(value:))
            .onEnded(onEnded(value:)))
        
        .ignoresSafeArea()
    }
    
    // pull down Player
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    //response: 0.5,
    //dampingFraction: 0.95,
    //blendDuration: 0.95
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.98, blendDuration: 0.69)) {
            if value.translation.height > UIScreen.main.bounds.height / 12 {
                expand = false
            }
            offset = 0
        }
    }
}

extension PlayerView {
    enum ExampleMusic {
        static let songName = "Cold Heart"
        static let songArtist = "Elton John"
        static let songTime = 215
    }
}

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurView =  UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}



//public extension View {
//    func animationObserver<Value: VectorArithmetic>(for value: Value,
//                                                    onChange: ((Value) -> Void)? = nil,
//                                                    onComplete: (() -> Void)? = nil) -> some View {
//      self.modifier(AnimationObserverModifier(for: value,
//                                                 onChange: onChange,
//                                                 onComplete: onComplete))
//    }
//}
//
//
//public struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {
//  // this is the view property that drives the animation - offset, opacity, etc.
//  private let observedValue: Value
//  private let onChange: ((Value) -> Void)?
//  private let onComplete: (() -> Void)?
//
//  // SwiftUI implicity sets this value as the animation progresses
//  public var animatableData: Value {
//    didSet {
//      notifyProgress()
//    }
//  }
//
//  public init(for observedValue: Value,
//              onChange: ((Value) -> Void)?,
//              onComplete: (() -> Void)?) {
//    self.observedValue = observedValue
//    self.onChange = onChange
//    self.onComplete = onComplete
//    animatableData = observedValue
//  }
//
//  public func body(content: Content) -> some View {
//    content
//  }
//
//  private func notifyProgress() {
//    DispatchQueue.main.async {
//      onChange?(animatableData)
//      if animatableData == observedValue {
//        onComplete?()
//      }
//    }
//  }
//}
