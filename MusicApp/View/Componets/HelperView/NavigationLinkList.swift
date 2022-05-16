//
//  NavigationLinkList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 05.05.2022.
//

import SwiftUI

struct NavigationLinkList<Content: View, Enum: RawRepresentable & CaseIterable & Hashable> : View where Enum.AllCases: RandomAccessCollection, Enum.RawValue == Int {
    var rowItems: Enum.Type
    var content: [Content]
    
    var body: some View {
        GeometryReader { proxy in
            List {
                ForEach(rowItems.allCases, id: \.self) { rowTitle in
                    NavigationLink {
                        content[rowTitle.rawValue]
                    } label: {
                        Text(String(describing: rowTitle))
                    }
                }
            }
            .listStyle(.plain)
            .frame(height: proxy.size.height)
        }
        
    }
}
