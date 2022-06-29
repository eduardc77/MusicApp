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
        List {
            ForEach(rowItems.allCases, id: \.self) { rowTitle in
                NavigationLinkRow(text: String(describing: rowTitle), destinationView: content[rowTitle.rawValue])
            }
        }
        .listStyle(.plain)
    }
}
