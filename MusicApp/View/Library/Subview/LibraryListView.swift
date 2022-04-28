//
//  LibraryListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryListView: View {
    @Binding var editMode: EditMode 
    @State var selection: Set<LibraryListModel> = []
    @State var options = libraryList
    
    var body: some View {
        List(selection: $selection) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.icon)
                        .frame(width: 66, height: 66)
                        .foregroundColor(.red)
                    Text(option.title)
                }
            }
            .onMove(perform: move)
            .listRowBackground(Color.white)
        }
        .environment(\.editMode, $editMode)
        .accentColor(.red)
        
        .listStyle(.plain)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.options.move(fromOffsets: source, toOffset: destination)
    }
}

struct LibraryListView_Previews: PreviewProvider {
    struct LibraryListViewExample: View {
        @State var editMode: EditMode = .active
        
        var body: some View {
            LibraryListView(editMode: $editMode)
        }
    }
    
    
    static var previews: some View {
        LibraryListViewExample()
    }
}
