//
//  Size.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 23.08.2022.
//

import Foundation

struct Size {
    var width: CGFloat? = nil
    var height: CGFloat? = nil
}

enum SizeType {
    case trackRowItem
    case artistRow
    case searchRow
    case albumCollectionRow
    case albumCarouselItem
    case albumDetail
    case categoryItem
    case smallPlayerVideo
    case videoListRow
    case videoCollectionRow
    case videoCarouselItem
    case highlight
    case highlightCard
    case largeHighlight
    case largePlayerArtwork
    case defaultSize

    var size: Size {
        switch self {
        case .trackRowItem: return Size(width: Metric.trackCarouselImageSize, height: Metric.trackCarouselImageSize)
        case .searchRow, .artistRow: return Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize)
        case .albumCollectionRow: return Size(width: 100, height: 100)
        case .albumCarouselItem: return Size(width: Metric.albumCarouselImageSize, height: Metric.albumCarouselImageSize)
        case .albumDetail: return Size(width: Metric.albumDetailArtworkSize, height: Metric.albumDetailArtworkSize)
        case .categoryItem: return Size(width: Metric.categoryRowItemWidth, height: Metric.categoryRowItemHeight)
        case .smallPlayerVideo: return Size(width: Metric.searchResultImageSize, height: Metric.smallPlayerVideoHeight)
        case .videoListRow: return Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize)
        case .videoCollectionRow: return Size(width: Metric.albumCarouselImageSize, height: Metric.videoRowHeight)
        case .videoCarouselItem: return Size(width: Metric.largeCarouselItemWidth , height: Metric.videoCarouselItemHeight)
        case .highlight: return Size(width: Metric.largeCarouselItemWidth, height: Metric.highlightItemImageSize)
        case .highlightCard: return Size()
        case .largeHighlight: return Size()
        case .largePlayerArtwork: return Size(width: Metric.largeMediaArtworkSize, height: Metric.largeMediaArtworkSize)
        case .defaultSize: return Size()
        }
    }
}
