//
//  DefaultView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct DefaultView: View {
    let title: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            EmptyView()
                .navigationBarTitle(title, displayMode: .inline)
                .navigationBarItems(leading: DismissButton(title: "Done", presentationMode: _presentationMode))
        }
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView(title: "Default")
    }
}
