//
//  LibraryView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryView: View {
    @State var showOptions = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    if showOptions {
                        LibraryListView()
                            .transition(.asymmetric(
                                insertion: .scale,
                                removal: .opacity))
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                    }
                    else {
                        VStack {
                            Text("Library")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 1)
                                
                            Text("Placeholder Placeholder iTunes Store Placeholder.")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 50)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                showOptions.toggle()
                }
            }) {
                showOptions ? Text("Placeholder") : Text("PlaceholderOption")
            })
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
