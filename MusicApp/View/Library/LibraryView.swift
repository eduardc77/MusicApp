//
//  LibraryView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct LibraryView: View {
    @Binding var tabSelection: Int
    @State var showOptions = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    if showOptions {
                        LibraryListView()
                            .transition(.asymmetric(
                                insertion: .scale,
                                removal: .opacity))
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                    }
                    else {
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
                            
                            Button { tabSelection = 1 } label: {
                                Text("Browse Apple Music")
                                    .font(.title3)
                                    .bold()
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(.red)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 50)
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    Spacer(minLength: Metric.playerHeight)
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
        LibraryView(tabSelection: .constant(0))
    }
}
