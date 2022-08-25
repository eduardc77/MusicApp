//
//  DefaultView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct DefaultView: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    
    var body: some View {
        NavigationView {
            EmptyView()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: DismissButton(title: "Done", presentationMode: _presentationMode))
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView(title: "Default")
    }
}
