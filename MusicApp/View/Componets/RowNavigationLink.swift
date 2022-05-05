//
//  RowNavigationLink.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 04.05.2022.
//

import SwiftUI

struct RowNavigationLink<Content: View>: View {
    let text: String
    var presentedView: Content
    
    var body: some View {
        NavigationLink(destination: presentedView) {
            HStack {
                Text(text)
            }
        }
    }
}


struct RowNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        RowNavigationLink(text: "Notifications", presentedView: ProfileView())
    }
}
