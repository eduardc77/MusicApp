//
//  Account.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 28.04.2022.
//

import Foundation

struct Account {
    var name: String = "John Appleseed"
    var username: String = "john_appleseed"
    var email: String = "john.appleseed@icloud.com"
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
