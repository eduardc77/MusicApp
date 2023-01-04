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
        Divider()
          .padding(.horizontal)
        
        ForEach(searchObservableObject.searchResults, id: \.id) { media in
          Spacer(minLength: 12)
          
          switch media.wrapperType {
          case .collection:
            SearchWrapperRow(media: media, destinationView: AlbumDetailView(media: media, searchObservableObject: searchObservableObject))
          case .track:
            SearchResultsRow(media: media, isPlaying: playerObservableObject.nowPlayingItem.$playing)
          case .artist:
            SearchWrapperRow(media: media, destinationView: ArtistDetailView(media: media))
          }
          
          Divider()
        }
        .padding(.horizontal)
        
        if playerObservableObject.showPlayerView, !playerObservableObject.expand {
          Spacer(minLength: Metric.playerHeight)
        }
      }
    }
    .dismissKeyboardOnScroll()
    
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
          
          .onChange(of: selectedPickerIndex) { tag in
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
      .background(.ultraThinMaterial)
      
    }
  }
}

struct MediaKindSegmentedControl: View {
  @ObservedObject var searchObservableObject: SearchObservableObject
  @State var selectedMediaKind: MediaKind = .album
  @Namespace var animation
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(MediaKind.allCases, id: \.self) { mediaKind in
          Button(action: {
            withAnimation {
              searchObservableObject.select(mediaKind)
              selectedMediaKind = mediaKind
            }
          }) {
            Text(mediaKind.title)
              .font(.footnote.weight(.medium))
              .padding(.vertical, 8)
              .padding(.horizontal)
              .background(
                ZStack {
                  if selectedMediaKind == mediaKind {
                    RoundedRectangle(cornerRadius: 20)
                      .fill(Color.accentColor)
                      .matchedGeometryEffect(id: "TAB", in: animation)
                  }
                }
              )
              .foregroundColor(selectedMediaKind == mediaKind ? .white : .primary)
          }
          .buttonStyle(.plain)
        }
      }
      .padding(.horizontal)
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
