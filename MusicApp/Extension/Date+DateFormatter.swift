//
//  Date+DateFormatter.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

extension Date {
    static let mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    var mediumDateStyle: String {
        Self.mediumDateFormatter.string(from: self)
    }
}
