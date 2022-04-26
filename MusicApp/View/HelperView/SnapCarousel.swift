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
