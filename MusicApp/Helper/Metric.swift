//
//  Metric.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

enum Metric {
    // MARK: - Search
    static let playerSmallImageSize: CGFloat = 48
    static let searchResultImageSize: CGFloat = 56
    static let searchResultCornerRadius: CGFloat = 4
    
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let playerHeight: CGFloat = 66
    static let regularSpacing: CGFloat = 16
    static let yOffset: CGFloat = -48
    static let capsuleWidth: CGFloat = 36
    static let capsuleHeight: CGFloat = 5
    static let largeMediaImage: CGFloat = UIScreen.main.bounds.height / 3.33
    static let albumDetailHeaderHeight: CGFloat = UIScreen.main.bounds.height / 2.2
    
    // MARK: - Horizontal List and Library List
    static let smallImageSize: CGFloat = 50
    static let mediumImageSize: CGFloat = 160
    static let largeImageSize: CGFloat = 186
    
    static let smallRowHeight: CGFloat = 55
    static let mediumRowHeight: CGFloat = 196
    static let largeRowHeight: CGFloat = UIScreen.main.bounds.height * 0.37
    
    // MARK: - TimeView
    static let largePoint: CGFloat = 32
    static let smallPoint: CGFloat = 6
    static let timeLineHeight: CGFloat = 3
}

enum ImageSizeType {
    case small
    case medium
    case large
}

struct Size {
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
}
