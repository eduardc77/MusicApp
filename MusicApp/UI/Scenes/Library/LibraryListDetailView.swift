//
//  LibraryListDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 30.04.2022.
//

import SwiftUI

struct LibraryListDetailView: View {
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var libraryModel: LibraryModel
   @State private var sort: SortOrder = .forward
   @State private var searchTerm = ""
   @Binding var tabSelection: Tab
   
   var section: LibrarySection
   
   var body: some View {
      Group {
      if libraryModel.loadingLibrary {
         ProgressView()
      } else {
         
            if let libraryContent = libraryModel.libraryContent[section], let kind = libraryContent.first?.wrapperType {
               VerticalMediaGridView(mediaItems: libraryContent, imageSize: kind == .collection ? .albumCarouselItem : .trackRowItem)
            } else {
               VStack {
                  EmptyLibraryView(title: section.title, tabSelection: $tabSelection)
               }
            }
         }
         
      }.navigationTitle(section.title)
         .searchable(text: $searchTerm,
                     placement:.navigationBarDrawer(displayMode:.always),
                     prompt: "Find in \(section.title)")
         
         .toolbar {
            ToolbarButton(title: "Sort", iconName: "arrow.up.arrow.down", action: {})
         }
   }
}


// MARK: - Previews

struct LibraryListDetailView_Previews: PreviewProvider {
   @State static var tabSelection: Tab = .browse
   
   static var previews: some View {
      LibraryListDetailView(libraryModel: LibraryModel(), tabSelection: $tabSelection, section: .albums)
         .environmentObject(PlayerModel())
   }
}
