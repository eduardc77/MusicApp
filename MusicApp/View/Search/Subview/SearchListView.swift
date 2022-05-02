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
    @StateObject private var searchListObservableObject: SearchListObservableObject = SearchListObservableObject()
    
    var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    var columns = [GridItem(.flexible(), alignment: .leading)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                Divider()
                ForEach(searchObservableObject.searchResults, id: \.id) { item in
                    SearchResultsRowItem(
                        media: item,
                        imageData: searchObservableObject.imagesData[item.artworkUrl100 ?? URL(fileURLWithPath: "")]
                    )
                    .onAppear {
                        guard item == searchObservableObject.searchResults[searchObservableObject.searchResults.count - 1] else { return }
                        searchObservableObject.loadMore()
                    }
                    .onTapGesture {
                        searchListObservableObject.media = item
                        searchListObservableObject.playSongAt(songIndex: 1)
                    }
                    
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged({ _ in
                                hideKeyboard()
                            }))
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    Divider()
                }
            }.padding(.horizontal)
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
