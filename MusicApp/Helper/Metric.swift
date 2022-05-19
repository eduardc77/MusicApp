//
//  Metric.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

enum Metric {
    // MARK: - Default
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let defaultCornerRadius: CGFloat = 4
    static let largeCarouselItemWidth: CGFloat = Metric.screenWidth * 0.9
    
    // MARK: - Player
    static let playerHeight: CGFloat = 66
    static let regularSpacing: CGFloat = 16
    static let yOffset: CGFloat = -48
    static let capsuleWidth: CGFloat = 36
    static let capsuleHeight: CGFloat = 5
    static let largeMediaImageSize: CGFloat = UIScreen.main.bounds.height / 3.33
    
    // MARK: - Artist Detail
    
    static let mediaPreviewHeaderHeight: CGFloat = UIScreen.main.bounds.height / 2.45
    
    // MARK: - Artwork
    static let albumDetailImageSize: CGFloat = 233
    
    static let trackCarouselImageSize: CGFloat = Metric.screenHeight * 0.06
    static let searchResultImageSize: CGFloat = Metric.screenHeight * 0.07
    static let playlistRowHeight: CGFloat = Metric.screenHeight * 0.12
    static let albumCarouselImageSize: CGFloat = Metric.screenHeight * 0.196
    static let trackRowItemHeight: CGFloat = Metric.screenHeight * 0.07
    static let albumRowItemHeight: CGFloat = Metric.screenHeight * 0.24
    static let videoRowHeight: CGFloat = Metric.screenHeight * 0.11
    static let videoCarouselItemHeight: CGFloat = Metric.screenHeight * 0.233
    static let categoryRowItemWidth: CGFloat = Metric.screenWidth / 2.29
    static let categoryRowItemHeight: CGFloat = Metric.screenHeight * 0.136
    static let largeRowItemHeight: CGFloat = Metric.screenHeight * 0.28
    static let highlightCarouselItemHeight: CGFloat = Metric.screenHeight * 0.37
    
    // MARK: - TimeView
    static let largePoint: CGFloat = 32
    static let smallPoint: CGFloat = 6
    static let timeLineHeight: CGFloat = 3
}

enum SizeType {
    case track
    case album
    case musicVideoRow
    case musicVideoItem
    case highlight
    case highlightCard
    case largeHighlight
}

struct Size {
    var width: CGFloat? = nil
    var height: CGFloat? = nil
}
