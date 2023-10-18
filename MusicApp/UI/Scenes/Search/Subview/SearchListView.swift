//
//  SearchListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchListView: View {
   @Environment(\.isSearching) private var isSearching
   @EnvironmentObject private var playerModel: PlayerModel
   @ObservedObject var searchModel: SearchViewModel
   @State var selectedPickerIndex = 0
   @State var isPresented = false
   
   var body: some View {
      ScrollViewReader { proxy in
         ScrollView {
            VStack {
               ForEach(Array(searchModel.searchResults.enumerated()), id: \.element) { mediaIndex, media in
                  Button {
                     withAnimation {
                        playerModel.play(media, videoAssetUrl: media.previewUrl)
                     }
                  } label: {
                     VStack(spacing: 0) {
                        if mediaIndex == 0 { Divider() }
                        Spacer()
                        
                        switch media.wrapperType {
                           case .collection:
                              SearchWrapperRow(media: media, destinationView: AlbumDetailView(media: media))
                           case .track:
                              SearchResultsRow(media: media)
                           case .artist:
                              SearchWrapperRow(media: media, destinationView: ArtistDetailView(media: media))
                        }
                        Spacer()
                        Divider()
                     }
                     .padding(.horizontal)
                     .frame(maxWidth: .infinity)
                     .contentShape(Rectangle())
                  }
                  .id(mediaIndex)
                  .buttonStyle(.rowButton)
                  .transition(.opacity)
                  
                  .contextMenu {
                     ForEach(MenuItem.allCases.reversed(), id: \.self) { menuItem in
                        Group {
                           switch menuItem {
                              case .viewCredits:
                                 Divider()
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                              case .deleteFromLibrary:
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon, buttonRole: .destructive)
                              case .addToAPlaylist:
                                 Divider()
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                              case .createStation:
                                 Divider()
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                              case .suggestLess:
                                 Divider()
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                              default:
                                 MenuItemButton(isPresented: $isPresented, title: menuItem.title, icon: menuItem.icon)
                           }
                        }.tag(menuItem)
                     }
                  } preview: {
                     NavigationLink(destination:
                                       AlbumDetailView(media: media)) {
                        ContextMenuTrackRow(media: media)
                     }
                                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                                       .padding(.horizontal)
                  }
               }
               if playerModel.showPlayerView, !playerModel.expand {
                  Spacer(minLength: Metric.playerHeight)
               }
            }
         }
         .scrollDismissesKeyboard(.immediately)
         
         .onChange(of: searchModel.selectedMediaType, { oldValue, newValue in
            guard oldValue != newValue else { return }
            proxy.scrollTo(0)
         })
         
         .safeAreaInset(edge: .top) {
            Group {
               if searchModel.searchSubmit {
                  MediaTypeSegmentedControl(searchModel: searchModel)
               } else {
                  Picker("Search In", selection: $selectedPickerIndex) {
                     Text("Apple Music").tag(0)
                     Text("Your Library").tag(1)
                  }
                  .pickerStyle(.segmented)
                  .padding(.horizontal)
                  
                  .onChange(of: selectedPickerIndex) { _, tag in
                     if tag == 0 {
                        searchModel.searchPrompt = .appleMusic
                     } else {
                        searchModel.searchPrompt = .library
                     }
                  }
                  .onAppear {
                     selectedPickerIndex = searchModel.searchPrompt.rawValue
                  }
               }
            }
            .padding(.vertical, 10)
            .background(.bar)
         }
      }
      .sheet(isPresented: self.$isPresented) {
         DefaultView(title: "Detail View")
      }
   }
}


// MARK: - Previews

struct SearchListView_Previews: PreviewProvider {
   static var previews: some View {
      SearchListView(searchModel: SearchViewModel())
         .environmentObject(PlayerModel())
   }
}
