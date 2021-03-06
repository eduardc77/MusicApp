//
//  LibraryView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    @Binding var tabSelection: Tab
    @State var editMode: EditMode = .inactive
    @StateObject private var libraryObservableObject = LibraryObservableObject()
    
    var body: some View {
        NavigationView {
            if libraryObservableObject.refreshingLibrary {
                LoadingView()
            } else {
                if libraryObservableObject.status == .permitted {
                    if !libraryObservableObject.albums.isEmpty {
                        ScrollView {
                            VStack {
                                LibraryListView(libraryObservableObject: libraryObservableObject, editMode: $editMode)
                                
                                if !editMode.isEditing {
                                    VerticalMediaGridView(mediaItems: libraryObservableObject.recentlyAdded, title: "Recently Added", imageSize: .album, rowCount: 2)
                                }
                            }
                        }
                        .navigationTitle("Library")
                        .toolbar { EditButton() }
                        .environment(\.editMode, $editMode)
                        
                    } else {
                        EmptyLibraryView(tabSelection: $tabSelection)
                    }
                } else if libraryObservableObject.status == .notPermitted {
                    RequestAuthorizationView()
                }
            }
        }
        .onAppear {
            guard !libraryObservableObject.refreshComplete else { return }
            libraryObservableObject.refreshAllLibrary()
        }
    }
    
    struct RequestAuthorizationView: View {
        @Environment(\.openURL) private var openURL
        
        var body: some View {
            VStack(spacing: 2) {
                Spacer()
                
                Text("No Access to Your Library")
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                Text("Allow access to your media library to add your favorite songs and playlists.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        openURL(url)
                    }
                } label: {
                    Text("Open Settings")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth:.infinity)
                        .padding(.vertical, 8)
                }
                .tint(.red)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .padding(.top, 10)
                
                Spacer()
            }
        }
    }
    
    struct EmptyLibraryView: View {
        @Binding var tabSelection: Tab
        
        var body: some View {
            VStack {
                Spacer()
                
                Text("Add Music to Your Library")
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                Text("Browse millions of songs and collect your favorites here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Button { tabSelection = .browse } label: {
                    Text("Browse Apple Music")
                        .font(.title3).bold()
                        .frame(maxWidth:.infinity)
                        .padding(.vertical, 8)
                    
                }
                .tint(.red)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    struct LibraryViewExample: View {
        @State var editMode: EditMode = .active
        @State var tabSelection: Tab = .browse
        
        var body: some View {
            LibraryView(tabSelection: $tabSelection)
        }
    }
    
    
    static var previews: some View {
        LibraryViewExample()
    }
}
