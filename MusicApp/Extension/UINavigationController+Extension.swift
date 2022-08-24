//
//  UINavigationController+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.08.2022.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
