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
	case albumRow
	case albumCarouselItem
	case artistFeatureAlbumItem
	case albumDetail
	case categoryCollectionRow
	case smallPlayerVideo
	case smallPlayerAudio
	case videoListRow
	case videoCollectionRow
	case videoCarouselItem
	case highlightCarouselItem
	case largePlayerArtwork
	case none

	var size: Size {
		switch self {
		case .trackRowItem: return Size(width: Metric.trackCarouselImageSize, height: Metric.trackCarouselImageSize)
		case .searchRow, .artistRow: return Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize)
		case .albumRow: return Size(width: Metric.albumRowHeight, height: Metric.albumRowHeight)
		case .albumCarouselItem: return Size(width: Metric.albumCarouselImageSize, height: Metric.albumCarouselImageSize)
		case .artistFeatureAlbumItem:  return Size(width: Metric.artistFeaturedAlbumRowHeight, height: Metric.artistFeaturedAlbumRowHeight)
		case .albumDetail: return Size(width: Metric.albumDetailArtworkSize, height: Metric.albumDetailArtworkSize)
		case .categoryCollectionRow: return Size(width: Metric.categoryRowItemWidth, height: Metric.categoryRowItemHeight)
		case .smallPlayerAudio: return  Size(width: Metric.smallPlayerImageSize, height: Metric.smallPlayerImageSize)
		case .smallPlayerVideo: return Size(width: Metric.searchResultImageSize, height: Metric.smallPlayerVideoHeight)
		case .videoListRow: return Size(width: Metric.searchResultImageSize, height: Metric.searchResultImageSize)
		case .videoCollectionRow: return Size(width: Metric.albumCarouselImageSize, height: Metric.videoRowHeight)
		case .videoCarouselItem: return Size(width: Metric.largeCarouselItemWidth , height: Metric.videoCarouselItemHeight)
		case .highlightCarouselItem: return Size(width: Metric.largeCarouselItemWidth, height: Metric.highlightItemImageSize)
		case .largePlayerArtwork: return Size(width: Metric.largeMediaArtworkSize, height: Metric.largeMediaArtworkSize)
		case .none: return Size()
		}
	}

	var cornerRadius: CGFloat {
		switch self {
		case .trackRowItem, .searchRow, .artistRow, .smallPlayerVideo, .smallPlayerAudio: return 4
		case .albumRow, .albumCarouselItem, .albumDetail, .artistFeatureAlbumItem, .categoryCollectionRow, .videoListRow, .videoCollectionRow, .videoCarouselItem: return 8
		case .highlightCarouselItem, .largePlayerArtwork: return 12
		case .none: return 0
		}
	}
}
