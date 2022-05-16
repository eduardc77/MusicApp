//
//  Date+DateFormatter.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

extension DateFormatter {
    func configure(_ config: (inout DateFormatter) -> Void) -> DateFormatter {
        var copy: DateFormatter = self
        config(&copy)
        return copy
    }
    
    static var isoFormatter: DateFormatter {
        .init().configure {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
    }
    
    static var defaultFormatter: DateFormatter {
        .init().configure { $0.dateFormat = "d MMMM yyyy " }
    }
   
    static var yearFormatter: DateFormatter {
        .init().configure { $0.dateFormat = "yyyy" }
    }
}
