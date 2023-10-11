//
//  HorizontalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct HorizontalMediaGridView: View {
   
   enum ScrollBehaviour {
      case paging
      case viewAligned
   }
   
   @EnvironmentObject private var playerModel: PlayerModel
   @State var mediaItems: [Media]
   var title: String
   var imageSize: SizeType
   var gridRows: [GridItem]
   var maxHighlightShowing: Int
   var scrollBehavior: ScrollBehaviour
   
   init(mediaItems: [Media], title: String = "", imageSize: SizeType = SizeType.none, rowCount: Int = 1, maxHighlightShowing: Int = 8, scrollBehavior: ScrollBehaviour = .viewAligned) {
      self.mediaItems = mediaItems
      self.title = title
      self.imageSize = imageSize
      self.maxHighlightShowing = maxHighlightShowing
      self.scrollBehavior = scrollBehavior
      
      switch imageSize {
         case .trackRowItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.trackRowItemHeight), spacing: 0), count: rowCount)
         case .stationRow:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.stationRowHeight), spacing: 0), count: rowCount)
         case .albumCarouselItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.albumCarouselItemHeight), spacing: 16), count: rowCount)
         case .videoCarouselItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.largeRowItemHeight), spacing: 8), count: rowCount)
         case .highlightCarouselItem:
            gridRows = Array(repeating: .init(.flexible(minimum: Metric.highlightCarouselItemHeight), spacing: 8), count: rowCount)
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
                  case .stationRow:
                     TrackMediaRow(media: media, sizeType: .stationRow)
                  case .albumCarouselItem:
                     AlbumMediaRowItem(media: media)
                  case .videoCarouselItem:
                     VideoMediaItem(media: media)
                  case .highlightCarouselItem:
                     HighlightMediaItem(media: media)
                  default: AlbumMediaRowItem(media: media)
               }
            }
         }
         .scrollTargetLayout()
         .padding(.horizontal)
      }
      .scrollTargetBehavior(scrollBehavior == .viewAligned ? .viewAligned(limitBehavior: .never) : .viewAligned(limitBehavior: .always))
      .scrollClipDisabled()
      
      .if(!title.isEmpty) { view in
         view.labeledViewModifier(mediaItems: mediaItems, imageSize: imageSize, maxHighlightShowing: maxHighlightShowing, header: title)
      }
   }
}


// MARK: - Previews

struct HorizontalMediaGridView_Previews: PreviewProvider {
   static var previews: some View {
      VStack {
         HorizontalMediaGridView(mediaItems: musicPlaylists, title: "You Gotta Hear This", imageSize: .albumCarouselItem, rowCount: 2, scrollBehavior: .paging)
            .environmentObject(PlayerModel())
      }
   }
}
