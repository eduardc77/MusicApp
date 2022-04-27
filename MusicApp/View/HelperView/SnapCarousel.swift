//
//  SnapCarousel.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    @Binding var index: Int
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    var content: (T) -> Content
    var list: [T]
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var gridRows: [GridItem]
    var rowCount: Int
    
    init(
        spacing: CGFloat = 15,
        trailingSpace: CGFloat = 50,
        index: Binding<Int>,
        items: [T],
        rowCount: Int,
        @ViewBuilder content: @escaping(T) -> Content
    ) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.rowCount = rowCount
        gridRows = Array(repeating: .init(.flexible()), count: self.rowCount)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width: CGFloat = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing
            let listCount = (list.count  - 1) / rowCount
            
            LazyHGrid(rows: gridRows) {
                
                    ForEach(list) { item in
                        content(item)
                            .frame(width: abs(proxy.size.width - trailingSpace))
                    }
                    
                
                                    
                }.offset(x: (CGFloat(currentIndex) * -width)
                         + (currentIndex != 0 ? adjustmentWidth : 0)
                         + offset)
                .gesture(
                    DragGesture()
                        .updating($offset) { value, output, _ in
                            output = value.translation.width
                        }
                        .onEnded { value in
                            currentIndex = index
                        }
                        .onChanged({ value in
                            let offsetX: CGFloat = value.translation.width
                            let progress: CGFloat = -offsetX / width
                            let roundIndex: CGFloat
                            
                            
                            switch progress.sign {
                            case .minus:
                                roundIndex = abs(progress) > 0.10 ? -1 : 0
                            case .plus:
                                roundIndex = abs(progress) > 0.10 ? 1 : 0
                            }
                            
                            
                            index = max(min(currentIndex + Int(roundIndex), listCount), 0)
                        })
                )
                .padding(.horizontal, spacing)
                
                

            
            
        }
        .animation(.easeInOut, value: offset == 0)
    }
}




struct ContentsView: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.pink)
                .frame(width: 100, height: 100)
                .position(location)
                .gesture(
                    simpleDrag.simultaneously(with: fingerDrag)
                )
            if let fingerLocation = fingerLocation {
                Circle()
                    .stroke(Color.green, lineWidth: 2)
                    .frame(width: 44, height: 44)
                    .position(fingerLocation)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
