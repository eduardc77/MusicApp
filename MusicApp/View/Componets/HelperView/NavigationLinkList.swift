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
    var title: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            if !title.isEmpty {
                Text(title)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            VStack(spacing: 0) {
                Divider()
                    .padding(.leading)
                
                List {
                    ForEach(rowItems.allCases, id: \.self) { rowTitle in
                        NavigationLink {
                            content[rowTitle.rawValue]
                        } label: {
                            Text(String(describing: rowTitle))
                                .font(.body)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .listStyle(.plain)
                
                // FIXME: - Uncomment this when iOS 16 is available
                .scrollDisabled(true)
                
                Divider()
                    .padding(.leading)
            }
        }
        .frame(idealHeight: CGFloat(50 * rowItems.allCases.count), maxHeight: .infinity)
    }
}
