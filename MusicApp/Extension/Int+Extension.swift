//
//  Int+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 24.04.2022.
//

import Foundation

extension Int {
    func toTime() -> String {
        return String(format: "%1d:%02d", self / 60, self - self / 60 * 60)
    }
}
