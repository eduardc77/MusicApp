//
//  PlayerView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct PlayerView: View {
    var animation: Namespace.ID
    
    @Binding var expand: Bool
    
    var height = UIScreen.main.bounds.height / 3
 
    @State var songTimePosition: Int = 0
    
    @State var volume: CGFloat = 0
    
    @State var offset: CGFloat = 0
    
    @State var isPlaying = true
    
    var body: some View {
        VStack {
            VStack {
            Capsule()
                .frame(width: expand ? Metric.capsuleWidth : 0, height: expand ? Metric.capsuleHeight : 0)
                .opacity(expand ? 1 : 0)
                .padding(.vertical, expand ? 30 : 0)
            
            // mini Player
            HStack() {
                if expand {
                    Spacer()
                }
                
                Image("elton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: expand ? height : Metric.imageSize, height: expand ? height : Metric.imageSize)
                    .cornerRadius(6)
                    .shadow(radius: 6, x: 0, y: 3)
                //or
                //ImagePlaceholderView()
                
                if !expand {
                    Text("Cold Heart")  // ?? Text("Not Playing")
                        .font(.body)
                        .foregroundColor(.primary)
                        .matchedGeometryEffect(id: "Title", in: animation, properties: .position, anchor: .leading)
                }
                
                Spacer()
                
                if !expand {
                    Button(action: {
                            isPlaying.toggle()
                    },
                            label: {
                        isPlaying ?
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "Play", in: animation, properties: .position, anchor: .trailing)
                        :
                        Image(systemName: "pause.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "Pause", in: animation, properties: .position, anchor: .trailing)
                        }
                    )
                        
                    Button(action: {},
                            label: {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .matchedGeometryEffect(id: "Forward", in: animation, properties: .position, anchor: .trailing)
                        }
                    )
                }
            }
            .padding(.horizontal)
            }
            .frame(height: expand ? UIScreen.main.bounds.height / 2 :  Metric.playerHeight)
            
         
            
            // full screen Player
            if expand {

            VStack() {
               
                HStack {

                        VStack(alignment: .leading) {
                        Text("Cold Heart")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Title", in: animation, properties: .position, anchor: .leading)
                            
                        Text("Elton John")
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
               
            }.padding(.horizontal)
            .frame(height: UIScreen.main.bounds.height / 2)
            
            }
        }
    
        .background(.ultraThinMaterial)
        
        .onTapGesture {
            withAnimation(.spring()) {
                expand = true
            }
        }
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : Metric.yOffset)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
    }
    
    // pull down Player
    func onchanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.96, blendDuration: 0.96)) {
            if value.translation.height > UIScreen.main.bounds.height / 12 {
                expand = false
            }
            offset = 0
        }
    }
}

extension PlayerView {
    enum Metric {
        static let imageSize: CGFloat = 48
        static let playerHeight: CGFloat = 66
        static let regularSpacing: CGFloat = 16
        static let yOffset: CGFloat = -48
        static let capsuleWidth: CGFloat = 36
        static let capsuleHeight: CGFloat = 5
    }
    
    enum ExampleMusic {
        static let songName = "Sacrifice"
        static let songArtist = "Elton John"
        static let songTime = 215
    }

}


