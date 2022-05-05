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
    @ObservedObject private var libraryAuthorization = LibraryAuthorization()
    
    var body: some View {
        NavigationView {
            if libraryAuthorization.status == .permitted {
                if !libraryObservableObject.albums.isEmpty {
                    ScrollView {
                        VStack {
                            LibraryListView(libraryObservableObject: libraryObservableObject, editMode: $editMode)
                            
                            if !editMode.isEditing {
                                VStack {
                                    Text("Recently Added")
                                        .font(.title2.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                    
                                    VerticalMediaGridView(mediaItems: libraryObservableObject.recentlyAdded, imageSize: .medium, rowCount: 2)
                                }
                            }
                            Spacer(minLength: Metric.playerHeight)
                        }
                    }
                    .navigationTitle("Library")
                    .toolbar { EditButton() }
                    .environment(\.editMode, $editMode)
                    
                } else {
                    EmptyLibraryView(tabSelection: $tabSelection)
                }
            } else if libraryAuthorization.status == .notPermitted {
                RequestAuthorizationView()
            }
        }
    }
    
    struct RequestAuthorizationView: View {
        @Environment(\.openURL) private var openURL
        
        var body: some View {
            VStack(spacing: 2) {
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
            }
        }
    }
    
    struct EmptyLibraryView: View {
        @Binding var tabSelection: Tab
        
        var body: some View {
            VStack {
                Text("Add Music to Your Library")
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                Text("Browse millions of songs and collect your favorites here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Spacer()
                
                Button { tabSelection = .browse } label: {
                    Text("Browse Apple Music")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth:.infinity)
                        .padding(.vertical, 8)
                    
                }
                .tint(.red)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
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
