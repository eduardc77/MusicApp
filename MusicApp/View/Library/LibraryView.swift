//
//  LibraryView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    @StateObject fileprivate var libraryObservableObject = LibraryObservableObject()
    fileprivate(set) var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< libraryObservableObject.getAlbumsCount(), id: \.self) { index in
                        NavigationLink(destination: AlbumDetailView(media: libraryObservableObject.getAlbum(at: index), player: player)) {
                            
                            makeGridAlbumItem(index: index, libraryObservableObject: libraryObservableObject)
                        }
                    }
                }
                .navigationTitle("Library")
            }
            .onAppear {
                libraryObservableObject.refreshAlbums()
                if UserDefaults.standard.array(forKey: UserDefaultsKey.queueDefault) == nil || player.nowPlayingItem == nil {
                    if libraryObservableObject.getAlbumsCount() > 0 {
                        player.setQueue(with: MPMediaQuery.songs())
                        player.prepareToPlay()
                        player.skipToBeginning()
                    }
                }
            }
        }
    }
}

struct makeAlbumItemContents: View {
    let index: Int
    @ObservedObject var libraryObservableObject: LibraryObservableObject
    
    var body: some View {
        VStack{
            MediaImageView(image: libraryObservableObject.getAlbum(at: index).artwork, size: Size(width: 160, height: 160))
  
            VStack {
                Text(libraryObservableObject.getAlbum(at: index).collectionName ?? "")
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(libraryObservableObject.getAlbum(at: index).artistName ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
    }
}

struct makeGridAlbumItem: View {
    let index: Int
    @ObservedObject var libraryObservableObject: LibraryObservableObject
    
    var body: some View {
 
        makeAlbumItemContents(index: index, libraryObservableObject: libraryObservableObject)
       
        .padding()
    }
}
//
//struct LibraryView: View {
//    @Binding var tabSelection: Int
//    @State var showOptions = false
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                ScrollView {
//                    if showOptions {
//                        LibraryListView()
//                            .transition(.asymmetric(
//                                insertion: .scale,
//                                removal: .opacity))
//                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
//                    }
//                    else {
//                        VStack {
//                            Text("Add Music to Your Library")
//                                .font(.title2).bold()
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(.primary)
//                            
//                            Text("Browse millions of songs and collect your favorites here.")
//                                .font(.body)
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(.secondary)
//                                .padding(.horizontal)
//                            
//                            Button { tabSelection = 1 } label: {
//                                Text("Browse Apple Music")
//                                    .font(.title3)
//                                    .bold()
//                                    .frame(maxWidth:.infinity)
//                                    .padding(.vertical, 8)
//                                    
//                            }
//                            .tint(.red)
//                            .padding(.horizontal, 50)
//                            .frame(maxWidth: .infinity)
//                            .buttonStyle(.borderedProminent)
//                        }
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                    }
//                    Spacer(minLength: Metric.playerHeight)
//                }
//            }
//            .navigationTitle("Library")
//            .navigationBarItems(trailing: Button(action: {
//                withAnimation {
//                    showOptions.toggle()
//                }
//            }) {
//                showOptions ? Text("Done") : Text("Edit")
//            })
//        }
//    }
//}
//
//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView(tabSelection: .constant(0))
//    }
//}
