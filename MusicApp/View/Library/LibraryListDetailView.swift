//
//  LibraryListDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import SwiftUI

struct LibraryListDetailView: View {
    var title: String
    @State private var searchTerm = ""
    
    var body: some View {
        ScrollView {
            Divider()
        }
        .navigationTitle(title)
        .searchable(text: $searchTerm, prompt: "Find in \(title)")
    }
}

struct LibraryListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryListDetailView(title: "Library Detail View")
    }
}
