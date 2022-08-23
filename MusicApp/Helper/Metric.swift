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
    
    // MARK: - Player
    static let playerHeight: CGFloat = screenHeight * 0.08
    static let regularSpacing: CGFloat = 16
    static let yOffset: CGFloat = -48
    static let capsuleWidth: CGFloat = 36
    static let capsuleHeight: CGFloat = 5
    static let largeMediaArtworkSize: CGFloat = screenHeight / 3.33
    
    // MARK: - Artist Detail
    static let mediaPreviewHeaderHeight: CGFloat = screenHeight / 2.45
    
    // MARK: - Album Detail
    static let albumDetailArtworkSize: CGFloat = screenHeight / 3.56

    // MARK: - Carousel
    static let trackCarouselImageSize: CGFloat = Metric.screenHeight * 0.06
    static let searchResultImageSize: CGFloat = Metric.screenHeight * 0.07
    static let playlistRowHeight: CGFloat = Metric.screenHeight * 0.12
    static let albumCarouselImageSize: CGFloat = Metric.screenHeight * 0.196
    static let trackRowItemHeight: CGFloat = Metric.screenHeight * 0.07
    static let albumRowItemHeight: CGFloat = Metric.screenHeight * 0.26
    static let smallPlayerVideoHeight: CGFloat = Metric.screenHeight * 0.04
    static let videoRowHeight: CGFloat = Metric.screenHeight * 0.11
    static let videoCarouselItemHeight: CGFloat = Metric.screenHeight * 0.233
    static let largeCarouselItemWidth: CGFloat = Metric.screenWidth * 0.9
    static let categoryRowItemWidth: CGFloat = Metric.screenWidth / 2.29
    static let categoryRowItemHeight: CGFloat = Metric.screenHeight * 0.136
    static let largeRowItemHeight: CGFloat = Metric.screenHeight * 0.28
    static let highlightItemImageSize: CGFloat = Metric.screenHeight * 0.29
    static let highlightCarouselItemHeight: CGFloat = Metric.screenHeight * 0.42
    
    // MARK: - TimeView
    static let largePoint: CGFloat = 32
    static let smallPoint: CGFloat = 6
    static let timeLineHeight: CGFloat = 3
}
