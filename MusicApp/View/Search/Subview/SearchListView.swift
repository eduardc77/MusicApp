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
    @StateObject var playerObservableObject: PlayerObservableObject = PlayerObservableObject(player: MPMusicPlayerController.applicationMusicPlayer)
    @State private var selectedIndex = 0
    
    var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    var columns = [GridItem(.flexible(), alignment: .leading)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                Divider()
                
                ForEach(searchObservableObject.searchResults, id: \.id) { media in
                    switch media.wrapperType {
                    case .collection:
                        NavigationLink(destination: AlbumDetailView(media: media, searchObservableObject: searchObservableObject)) {
                            Section(footer: progressBar(for: media)) {
                                SearchResultsRowItem(
                                    media: media,
                                    imageData: searchObservableObject.imagesData[media.artworkUrl100 ?? URL(fileURLWithPath: "")]
                                )
                            }
                        }
                        .onAppear {
                            guard media == searchObservableObject.searchResults.last else { return }
                            Task {
                                await searchObservableObject.loadMore()
                            }
                        }
                        
                        
                        
                    case .track:
                        Section(footer: progressBar(for: media)) {
                            SearchResultsRowItem(
                                media: media,
                                imageData: searchObservableObject.imagesData[media.artworkUrl100 ?? URL(fileURLWithPath: "")]
                            )
                        }
                        .onAppear {
                            guard media == searchObservableObject.searchResults.last else { return }
                            Task {
                                await searchObservableObject.loadMore()
                            }
                        }
                        .onTapGesture {
                            guard media.wrapperType == .track else { return }
                            
                            playerObservableObject.player.setQueue(with: [media.id])
                            
                            playerObservableObject.player.play()
                            
                            hideKeyboard()
                        }
                    case .artist: EmptyView()
                        
                    default: EmptyView()
                        
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
    
    @ViewBuilder
    func progressBar(for media: Media) -> some View {
        if !searchObservableObject.loadingMoreComplete, searchObservableObject.isLoadingMore, media == searchObservableObject.searchResults.last {
            ProgressView()
                .padding(.vertical)
        }  else {
            EmptyView()
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
