//
//  LibraryAuthorization.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 29.04.2022.
//

import SwiftUI
import MediaPlayer

enum AuthorizationStatus {
    case notYetDetermined
    case permitted
    case notPermitted
}

final class LibraryAuthorization: ObservableObject {
    @Published private(set) var status: AuthorizationStatus = .notYetDetermined
    
    init() {
        getAuthrization()
    }
    
    private func getAuthrization()  {
        let status = MPMediaLibrary.authorizationStatus()
        
        guard status == MPMediaLibraryAuthorizationStatus.authorized else {
            MPMediaLibrary.requestAuthorization() { status in
                DispatchQueue.main.async {
                    self.status = status == .authorized ? .permitted : .notPermitted
                }
            }
            return
        }
        self.status = .permitted
    }
}
