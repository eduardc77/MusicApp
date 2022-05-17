//
//  Metric.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

enum Metric {
    // MARK: - Default
    static let defaultCornerRadius: CGFloat = 4
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - Player
    static let playerHeight: CGFloat = 66
    static let regularSpacing: CGFloat = 16
    static let yOffset: CGFloat = -48
    static let capsuleWidth: CGFloat = 36
    static let capsuleHeight: CGFloat = 5
    static let largeMediaImageSize: CGFloat = UIScreen.main.bounds.height / 3.33
    
    
    // MARK: - Artwork
    static let albumDetailImageSize: CGFloat = 233
    
    static let smallCarouselImageSize: CGFloat = 48
    static let searchResultImageSize: CGFloat = 56
    static let mediumCarouselImageSize: CGFloat = 160
    static let largeCarouselImageHeight: CGFloat = 184
    static let largeCarouselImageWidth: CGFloat = Metric.screenWidth - 44
    
    static let smallRowItemHeight: CGFloat = 55
    static let mediumRowItemHeight: CGFloat = 196
    static let largeRowItemHeight: CGFloat = UIScreen.main.bounds.height * 0.28
    static let highlightCarouselItemHeight: CGFloat = UIScreen.main.bounds.height * 0.37
    
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
