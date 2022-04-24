//
//  UIDevice+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import SwiftUI

extension UIDevice {
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}
