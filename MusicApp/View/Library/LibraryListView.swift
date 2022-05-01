//
//  LibraryListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryListView: View {
    @Binding var editMode: EditMode
    @State var selection: Set<LibraryListItem> = []
    @State var currentOptions = LibraryListItem.libraryList
  
    var body: some View {
        List(selection: $selection) {
            ForEach(currentOptions, id: \.self) { option in
                NavigationLink {
                    LibraryListDetailView(title: option.title)
                } label: {
                    HStack {
                        Image(systemName: option.systemImage)
                            .font(.title2)
                            .foregroundColor(.appAccentColor)
                            .frame(width: 32)
                        Text(option.title)
                            .font(.title2)
                    }
                    .frame(height: 36)
                }
            }
            .onMove(perform: move)
        }
        .listStyle(.plain)
        .frame(idealHeight: CGFloat(50 * currentOptions.count))
        
        .onChange(of: editMode, perform: { editMode in
            withAnimation {
                if !editMode.isEditing {
                    currentOptions = currentOptions.filter{ selection.contains($0) }
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(currentOptions), forKey: UserDefaultsKey.libraryListSelection)
                } else {
                    if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.orderedLibraryList) as? Data, let orderedLibraryList = try? PropertyListDecoder().decode(Array<LibraryListItem>.self, from: data) {
                        currentOptions = orderedLibraryList
                    } else {
                        currentOptions = LibraryListItem.libraryList
                    }
                }
            }
        })
        
        .onAppear {
            if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.libraryListSelection) as? Data, let librarySelection = try? PropertyListDecoder().decode(Array<LibraryListItem>.self, from: data) {
                selection = Set(librarySelection)
                currentOptions = Array(librarySelection)
            } else {
                currentOptions = LibraryListItem.defaultLibraryList
                selection = Set(currentOptions)
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        currentOptions.move(fromOffsets: source, toOffset: destination)
        LibraryListItem.libraryList = currentOptions
        UserDefaults.standard.set(try? PropertyListEncoder().encode(LibraryListItem.libraryList), forKey: UserDefaultsKey.orderedLibraryList)
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
