//
//  HorizontalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HorizontalMediaGridView: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@State var mediaItems = [Media]()
	var title: String
	var imageSize: SizeType
	var gridRows: [GridItem]
	var maxHighlightShowing: Int
	
	init(mediaItems: [Media], title: String = "", imageSize: SizeType, rowCount: Int = 1, maxHighlightShowing: Int = 8) {
		self.mediaItems = mediaItems
		self.title = title
		self.imageSize = imageSize
		self.maxHighlightShowing = maxHighlightShowing
		
		switch imageSize {
		case .trackRowItem:
			gridRows = Array(repeating: .init(.flexible(minimum: Metric.trackRowItemHeight), spacing: 0), count: rowCount)
		case .albumRow:
			gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumRowHeight), spacing: 0), count: rowCount)
		case .albumCarouselItem:
			gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumCarouselItemHeight), spacing: 8), count: rowCount)
		case .videoCarouselItem:
			gridRows = Array(repeating: .init(.flexible(minimum: Metric.largeRowItemHeight), spacing: 8), count: rowCount)
		default:
			gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumCarouselItemHeight), spacing: 10), count: rowCount)
		}
	}
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHGrid(rows: gridRows, spacing: 12) {
				ForEach(mediaItems.prefix(maxHighlightShowing), id: \.id) { media in

					switch imageSize {
					case .trackRowItem:
						TrackMediaRow(media: media)
					case .albumRow:
						TrackMediaRow(media: media, sizeType: .albumRow)
					case .albumCarouselItem:
						AlbumMediaItem(media: media)
					case .videoCarouselItem:
						VideoMediaItem(media: media)
					default: AlbumMediaItem(media: media)
					}
				}
			}
			.padding([.horizontal, .bottom])
		}
		.labeledViewModifier(mediaItems: mediaItems, imageSize: imageSize, maxHighlightShowing: maxHighlightShowing, header: title)
	}
}


// MARK: - Previews

struct HorizontalMediaGridView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear This", imageSize: .albumCarouselItem, rowCount: 2)
				.environmentObject(PlayerObservableObject())
		}
	}
}
