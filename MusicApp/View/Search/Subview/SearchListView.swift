//
//  SearchListView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct SearchListView: View {
    @ObservedObject var searchObservableObject: SearchObservableObject
    @StateObject var playerObservableObject: PlayerObservableObject = PlayerObservableObject()
    @State private var selectedIndex = 0
    
    var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    var columns = [GridItem(.flexible(), alignment: .leading)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                Divider()
                    .padding(.horizontal)
                
                ForEach(searchObservableObject.searchResults, id: \.id) { media in
                    switch media.wrapperType {
                    case .collection:
                        SearchWrapperRow(media: media, destinationView: AlbumDetailView(media: media, searchObservableObject: searchObservableObject))
                    case .track:
                        SearchResultsRow(media: media)
                        
                    case .artist:
                        SearchWrapperRow(media: media, destinationView: ArtistDetailView(media: media))
                    }
                    
                    Divider()
                }
                .padding(.horizontal)
                
                Spacer(minLength: Metric.playerHeight)
            }
        }
        
        .safeAreaInset(edge: .top) {
            Group {
                Picker("Search In", selection: $selectedIndex) {
                    Text("Apple Music").tag(0)
                    Text("Your Library").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(8)
                .background(BlurView())
                .clipped()
            }
        }
    }
}


struct SearchListView_Previews: PreviewProvider {
    static let searchObservableObject: SearchObservableObject = {
        let viewModel = SearchObservableObject()
        
        return viewModel
    }()
    
    static var previews: some View {
        SearchListView(searchObservableObject: searchObservableObject)
    }
}
