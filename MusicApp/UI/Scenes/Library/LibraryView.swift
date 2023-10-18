//
//  LibraryView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @StateObject private var libraryModel = LibraryModel()
   @Binding var tabSelection: Tab
   @State var editMode: EditMode = .inactive
   
   var body: some View {
      NavigationStack {
         if libraryModel.loadingLibrary {
            LoadingView()
         } else {
            if libraryModel.status == .permitted {
               if !libraryModel.emptyLibrary, !libraryModel.loadingLibrary {
                  ScrollView {
                     LibraryListView(libraryModel: libraryModel, editMode: $editMode, tabSelection: $tabSelection)
                     
                     if !editMode.isEditing {
                        VerticalMediaGridView(mediaItems: libraryModel.recentlyAdded, title: "Recently Added", imageSize: .albumCarouselItem, scrollDisabled: false)
                     }
                  }
                  .navigationTitle("Library")
                  .toolbar { EditButton() }
                  .environment(\.editMode, $editMode)
               } else {
                  EmptyLibraryView(tabSelection: $tabSelection)
               }
            } else if libraryModel.status == .notPermitted {
               RequestAuthorizationView()
            }
         }
      }
   }
}


// MARK: - Previews

struct LibraryView_Previews: PreviewProvider {
   struct LibraryViewExample: View {
      @State var editMode: EditMode = .inactive
      @State var tabSelection: Tab = .browse
      
      var body: some View {
         VStack {
            LibraryView(tabSelection: $tabSelection, editMode: editMode)
         }
      }
   }
   
   
   static var previews: some View {
      LibraryViewExample()
   }
}
