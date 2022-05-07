//
//  AccountView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var toggleContactsOnAppleMusic = true
    @State var toggleFindingByAppleId = true
    
    var body: some View {
        NavigationView {
            List {
                Section { ProfileNavigationLink(username: "John Appleseed", email: "john.appleseed@icloud.com") }
                
                Section {
                    RowButton(rowTitle: "Redeem Gift Card or Code", navigationTitle: "Redeem Code")
                } header: { Spacer(minLength: 1) }
                
                Section {
                    RowNavigationLink(text: "Notifications", presentedView: ProfileView())
                } header: { Spacer(minLength: 1) }
                
                Section {
                    Toggle(isOn: $toggleContactsOnAppleMusic) {
                        Text("Contacts on Apple Music")
                    }
                } header: {
                    Text("Find Friends".uppercased())
                    
                } footer: {
                    Text("Allow Apple Music to periodically check the contacts on your devices to recommend new friends.")
                }
                
                Section {
                    Toggle(isOn: $toggleFindingByAppleId) {
                        Text("Allow Finding by Apple ID")
                    }
                } header: {
                    Spacer(minLength: 1)
                } footer: {
                    Text("People who have your Apple ID contact information may see you as a recommended friend.")
                }
                
                Section {
                    RowButton(rowTitle: "Account Settings")
                } header: {
                    Spacer(minLength: 1)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: DismissButton(title: "Done", presentationMode: _presentationMode))
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
