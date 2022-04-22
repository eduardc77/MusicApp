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
    @State var isPlaying = false
   
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            
            Capsule()
                .fill(Color.secondary.opacity(0.5))
                .frame(width: expand ? Metric.capsuleWidth : 0, height: expand ? Metric.capsuleHeight : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ? 20 : 0)
            VStack {
                // Mini Player
                HStack {
                    if expand { Spacer() }
                    
                    MediaImageView(image: Image("elton"), size: (width: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize, height: expand ? Metric.largeMediaImage : Metric.playerSmallImageSize), cornerRadius: expand ? 10 : Metric.searchResultCornerRadius)
                        .scaleEffect((isPlaying && expand) ? 1.33 : 1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3), value: isPlaying)
                    // Or PlaceholderImage
                    // MediaImageView(size: (width: expand ? height : Metric.imageSize, height: expand ? height : Metric.imageSize), cornerRadius: expand ? 20 : 6)
                    
                    if !expand {
                        Text(ExampleMusic.songName)  // ?? Text("Not Playing")
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
                                Image(systemName: "pause.fill")
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                                :
                                Image(systemName: "play.fill")
                                    .font(.title)
                                    .foregroundColor(.primary)
                            }
                            )
                            .padding(.trailing)
                            
                            Button(action: {},
                                   label: {
                                Image(systemName: "forward.fill")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }
                            )
                        }
                    }
                }
            }
            .frame(height: expand ? UIScreen.main.bounds.height / 2.5 :  Metric.playerHeight)
            .padding()
            
            // Full Screen Player
            VStack {
            
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
                
                PlayerButtonsView(isPlaying: $isPlaying)
                
                VolumeView()
            }
            .frame(height: expand ? UIScreen.main.bounds.height / 2.5 : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : Metric.playerHeight)
        .background(
            VStack(spacing: 0) {
                if expand {
                    ZStack {
                        BlurView()
                       
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.6),
                                                        .blue.opacity(0.6),
                                                        .pink.opacity(0.6)]),
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
        .cornerRadius(expand ? (UIDevice.current.hasTopNotch ? 36 : 0) : 0)
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

extension UIDevice {
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 > 20
        }
        return false
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
