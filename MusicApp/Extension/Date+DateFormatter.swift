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

extension DateFormatter {
    func configure(_ config: (inout DateFormatter) -> Void) -> DateFormatter {
        var copy: DateFormatter = self
        config(&copy)
        return copy
    }
    
    static var defaultFormatter: DateFormatter {
        .init().configure { $0.dateFormat = "yyyy MMMM dd" }
    }
   
    static var yearFormatter: DateFormatter {
        .init().configure { $0.dateFormat = "yyyy" }
    }
}
