//
//  LibraryListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryListView: View {
   @ObservedObject var libraryModel: LibraryModel
   @Binding var editMode: EditMode
   @Binding var tabSelection: Tab
   @State var selection = Set<LibrarySection>()
   @State var currentSections = LibrarySection.allCases
   
   @State private var currentSelection = Set<LibrarySection>()
   
   var body: some View {
      List(selection: $selection) {
         ForEach(currentSections, id: \.self) { section in
            NavigationLink {
               LibraryListDetailView(libraryModel: libraryModel, tabSelection: $tabSelection, section: section)
                  .onAppear {
                     libraryModel.loadLibrary(for: section)
                  }
            } label: {
               Label {
                  Text(section.title)
               } icon: {
                  Image(systemName: section.systemImage)
                     .foregroundStyle(Color.accentColor)
               }
               .font(.title3)
            }
            .frame(height: 20)
         }
         .onMove(perform: move)
      }
      .environment(\.defaultMinListRowHeight, 20)
      .listStyle(.plain)
      .frame(height: CGFloat(44 * currentSections.count))
      .scrollDisabled(true)
      
      .onChange(of: selection) { _, newValue in
         currentSelection = newValue
      }
      
      .onChange(of: editMode) { _, editMode in
         withAnimation {
            if !editMode.isEditing {
               currentSections = currentSections.filter { currentSelection.contains($0) }
               UserDefaults.standard.set(try? libraryModel.propertyListEncoder.encode(currentSelection), forKey: UserDefaultsKey.libraryListSelection)
            } else {
               if let selectionData = UserDefaults.standard.value(forKey: UserDefaultsKey.libraryListSelection) as? Data, let librarySelection = try? libraryModel.propertyListDecoder.decode(Array<LibrarySection>.self, from: selectionData), !librarySelection.isEmpty {
                  selection = Set(librarySelection)
               } else {
                  selection = Set(LibrarySection.allCases)
               }
               currentSections = LibrarySection.allCases
               
               if let orderData = UserDefaults.standard.value(forKey: UserDefaultsKey.orderedLibraryList) as? Data, let orderedLibraryList = try? libraryModel.propertyListDecoder.decode(Array<LibrarySection>.self, from: orderData) {
                  currentSections = orderedLibraryList
               }
            }
         }
      }
      .onAppear {
         if let data = UserDefaults.standard.value(forKey: UserDefaultsKey.libraryListSelection) as? Data, let librarySelection = try? libraryModel.propertyListDecoder.decode(Array<LibrarySection>.self, from: data), !librarySelection.isEmpty {
            currentSections = Array(librarySelection)
            
            if let orderData = UserDefaults.standard.value(forKey: UserDefaultsKey.orderedLibraryList) as? Data, let orderedLibraryList = try? libraryModel.propertyListDecoder.decode(Array<LibrarySection>.self, from: orderData) {
               currentSections = orderedLibraryList.filter { librarySelection.contains($0) }
            }
         } else {
            currentSections = LibrarySection.allCases
         }
         
      }
   }
   
   func move(from source: IndexSet, to destination: Int) {
      currentSections.move(fromOffsets: source, toOffset: destination)
      UserDefaults.standard.set(try? libraryModel.propertyListEncoder.encode(currentSections), forKey: UserDefaultsKey.orderedLibraryList)
   }
}


// MARK: - Previews

struct LibraryListView_Previews: PreviewProvider {
   struct LibraryListViewExample: View {
      @State var tabSelection: Tab = .browse
      @State var editMode: EditMode = .active
      
      var body: some View {
         LibraryListView(libraryModel: LibraryModel(), editMode: $editMode, tabSelection: $tabSelection)
            .padding()
      }
   }
   
   static var previews: some View {
      LibraryListViewExample()
   }
}
