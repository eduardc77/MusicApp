//
//  TimeInterval+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.04.2022.
//

import Foundation

extension TimeInterval {
    var inSeconds: Int {
        let hour = (Int(self) % 86400) / 3600
        let minute = (Int(self) % 3600) / 60
        let second = (Int(self) % 3600) % 60
        
        if hour > 0 {
            return hour
        } else {
            return minute + second
        }
    }
    }
