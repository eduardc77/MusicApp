//
//  Metric.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

enum Metric {
   
   // MARK: - Screen Size
   
   static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
   static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
   
   // MARK: - Player
   
   static let playerHeight: CGFloat = screenHeight * 0.08
   static let regularSpacing: CGFloat = 16
   static let tabBarHeight: CGFloat = -48
   static let capsuleWidth: CGFloat = 36
   static let capsuleHeight: CGFloat = 5
   static let largeMediaArtworkSize: CGFloat = screenHeight / 3.33
   static let smallPlayerImageSize: CGFloat = Metric.screenHeight * 0.06
   
   // MARK: - Artist Detail
   
   static let mediaPreviewHeaderHeight: CGFloat = screenHeight / 2.15
   
   // MARK: - Album Detail
   
   static let albumDetailArtworkSize: CGFloat = screenHeight / 3.56
   
   // MARK: - Carousel
   
   static let trackCarouselImageSize: CGFloat = Metric.screenHeight * 0.068
   static let searchResultImageSize: CGFloat = Metric.screenHeight * 0.07
   static let stationRowHeight: CGFloat = Metric.screenHeight * 0.15
   static let artistFeaturedAlbumRowHeight: CGFloat = Metric.screenHeight * 0.112
   static let albumCarouselImageSize: CGFloat = Metric.screenHeight * 0.20
   static let albumCarouselItemHeight: CGFloat = Metric.screenHeight * 0.24
   static let trackRowItemHeight: CGFloat = Metric.screenHeight * 0.07
   static let smallPlayerVideoHeight: CGFloat = Metric.screenHeight * 0.04
   static let videoRowHeight: CGFloat = Metric.screenHeight * 0.11
   static let videoCarouselItemHeight: CGFloat = Metric.screenHeight * 0.233
   static let largeCarouselItemWidth: CGFloat = Metric.screenWidth * 0.9
   static let categoryRowItemWidth: CGFloat = Metric.screenWidth / 2.29
   static let categoryRowItemHeight: CGFloat = Metric.screenHeight * 0.136
   static let largeRowItemHeight: CGFloat = Metric.screenHeight * 0.28
   static let highlightCarouselItemHeight: CGFloat = Metric.screenHeight * 0.29
   
   // MARK: - Slider Views
   
   static let trackTimeSliderHeight: CGFloat = 50
   static let volumeSliderHeight: CGFloat = 40
   static let timeLineHeight: CGFloat = 6.6
}
