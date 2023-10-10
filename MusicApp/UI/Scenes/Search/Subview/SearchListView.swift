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
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   @ObservedObject var searchObservableObject: SearchObservableObject
   @State var selectedPickerIndex = 0
   
   var columns = [GridItem(.flexible(), spacing: 12)]
   
   var body: some View {
      ScrollView {
         LazyVGrid(columns: columns) {
            ForEach(Array(searchObservableObject.searchResults.enumerated()), id: \.element) { mediaIndex, media in
               Button {
                  withAnimation {
                     playerObservableObject.play(media, videoAssetUrl: media.previewUrl)
                  }
               } label: {
                  VStack(spacing: 0) {
                     if mediaIndex == 0 { Divider() }
                     Spacer()
                     
                     switch media.wrapperType {
                     case .collection:
                        SearchWrapperRow(media: media, destinationView:
                                          AlbumDetailView(media: media))
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
               .buttonStyle(.rowButton)
            }
            
            if playerObservableObject.showPlayerView, !playerObservableObject.expand {
               Spacer(minLength: Metric.playerHeight)
            }
         }
      }
      .scrollDismissesKeyboard(.immediately)
      
      .safeAreaInset(edge: .top) {
         Group {
            if searchObservableObject.searchSubmit {
               MediaKindSegmentedControl(searchObservableObject: searchObservableObject)
            } else {
               Picker("Search In", selection: $selectedPickerIndex) {
                  Text("Apple Music").tag(0)
                  Text("Your Library").tag(1)
               }
               
               .pickerStyle(.segmented)
               .padding(.horizontal)
               
               .onChange(of: selectedPickerIndex) { _, tag in
                  if tag == 0 {
                     searchObservableObject.searchPrompt = .appleMusic
                  } else {
                     searchObservableObject.searchPrompt = .library
                  }
               }
               .onAppear {
                  selectedPickerIndex = searchObservableObject.searchPrompt.rawValue
               }
            }
         }
         .padding(.vertical, 10)
         .background(.bar)
      }
   }
}


// MARK: - Previews

struct SearchListView_Previews: PreviewProvider {
   static var previews: some View {
      SearchListView(searchObservableObject: SearchObservableObject())
         .environmentObject(PlayerObservableObject())
   }
}
