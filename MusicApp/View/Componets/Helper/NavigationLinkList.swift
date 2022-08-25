//
//  NavigationLinkList.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 05.05.2022.
//

import SwiftUI

protocol Nameable {
  var title: String { get }
}

struct NavigationLinkList<Content: View, Enum: RawRepresentable & CaseIterable & Hashable & Nameable> : View where Enum.AllCases: RandomAccessCollection, Enum.RawValue == Int {
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
                    ForEach(rowItems.allCases, id: \.self) { enumCase in
                        NavigationLink {
                            content[enumCase.rawValue]
                        } label: {
                          Text(String(describing: enumCase.title))
                                .font(.body)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollingDisabled(true)
                
                Divider()
                    .padding(.leading)
            }
        }
        .frame(idealHeight: CGFloat(50 * rowItems.allCases.count), maxHeight: .infinity)
    }
}