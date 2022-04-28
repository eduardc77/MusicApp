//
//  AppNavigationBar.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import SwiftUI

struct AppNavigationBar: View {
    @State private var showingProfile = false
    
    private var title = "Listen Now"
    private var hasTrailingBarButtonItem = false

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .font(.largeTitle.bold())
                
                if hasTrailingBarButtonItem {
                Spacer()

                Button {
                    showingProfile.toggle()
                } label: {
                    Image(systemName: "person.crop.circle").font(.largeTitle)
                }
                }
            }
            .sheet(isPresented: $showingProfile) {
                AccountSummary(account: Account())
            }
            .padding(.horizontal)

            Divider()
        }
        
    }

}
