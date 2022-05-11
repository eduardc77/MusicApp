//
//  LibraryListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryListView: View {
    @ObservedObject var libraryObservableObject: LibraryObservableObject
    @Binding var editMode: EditMode
    @State var selection = Set<LibrarySection>()
    @State var currentSections = LibrarySection.allCases
    
    var body: some View {
        List(selection: $selection) {
            ForEach(currentSections, id: \.self) { section in
                NavigationLink {
                    LibraryListDetailView(libraryObservableObject: libraryObservableObject, section: section)
                } label: {
                    HStack {
                        Image(systemName: section.systemImage)
                            .font(.title2)
                            .foregroundColor(.appAccentColor)
                            .frame(minWidth: 32)
                        
                        Text(section.title)
                            .font(.title2)
                    }
                    .frame(minWidth: 36)
                }
            }
            .onMove(perform: move)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .frame(idealHeight: CGFloat(46 * currentSections.count), maxHeight: .infinity)
        
        .onChange(of: editMode, perform: { editMode in
            withAnimation {
                if !editMode.isEditing {
                    currentSections = currentSections.filter { selection.contains($0) }
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(currentSections), forKey: UserDefaultsKey.libraryListSelection)
                } else {
                    if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.orderedLibraryList) as? Data, let orderedLibraryList = try? PropertyListDecoder().decode(Array<LibrarySection>.self, from: data) {
                        currentSections = orderedLibraryList
                    } else {
                        currentSections = LibrarySection.allCases
                    }
                }
            }
        })
        .onAppear {
            if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.libraryListSelection) as? Data, let librarySelection = try? PropertyListDecoder().decode(Array<LibrarySection>.self, from: data) {
                selection = Set(librarySelection)
                currentSections = Array(librarySelection)
            } else {
                currentSections = LibrarySection.allCases
                selection = Set(currentSections)
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        currentSections.move(fromOffsets: source, toOffset: destination)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentSections), forKey: UserDefaultsKey.orderedLibraryList)
    }
}

struct LibraryListView_Previews: PreviewProvider {
    struct LibraryListViewExample: View {
        @State var editMode: EditMode = .active
        
        var body: some View {
            LibraryListView(libraryObservableObject: LibraryObservableObject(), editMode: $editMode)
        }
    }
    
    static var previews: some View {
        LibraryListViewExample()
    }
}
