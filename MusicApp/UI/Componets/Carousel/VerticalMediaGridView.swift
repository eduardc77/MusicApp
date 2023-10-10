//
//  VerticalMediaGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import MediaPlayer

struct VerticalMediaGridView: View {
   @EnvironmentObject private var playerObservableObject: PlayerObservableObject
   @State var mediaItems = [Media]()
   
   var title: String
   var imageSize: SizeType
   var topPadding: CGFloat = 8
   var columns: [GridItem]
   @State var gridSpacing: CGFloat?
   var scrollDisabled: Bool
   
   init(mediaItems: [Media], title: String = "", imageSize: SizeType, scrollDisabled: Bool = false, topPadding: CGFloat = 8) {
      self.mediaItems = mediaItems
      self.title = title
      self.imageSize = imageSize
      self.scrollDisabled = scrollDisabled
      self.topPadding = topPadding
      
      switch imageSize {
      case .trackRowItem:
         columns = Array(repeating: .init(.flexible(), spacing: 0), count: 1)
         setupGridSpacing(gridSpacing, defaultSpace: 2)
      case .stationRow:
         columns = Array(repeating: .init(.flexible(), spacing: 0), count: 1)
         setupGridSpacing(gridSpacing, defaultSpace: 2)
      case .albumCarouselItem, .videoCarouselItem:
         columns = Array(repeating: .init(.flexible(), spacing: 24), count: 2)
         setupGridSpacing(gridSpacing, defaultSpace: 24)
      default:
         columns = Array(repeating: .init(.flexible(), spacing: 10), count: 2)
         setupGridSpacing(gridSpacing, defaultSpace: 16)
      }
   }
   
   var body: some View {
      ScrollView {
         LazyVGrid(columns: columns, spacing: gridSpacing) {
            ForEach(Array(zip(mediaItems.indices, mediaItems)), id: \.0) { _, media in
               switch imageSize {
               case .trackRowItem:
                  TrackMediaRow(media: media)
               case .stationRow:
                  TrackMediaRow(media: media, sizeType: .stationRow)
               case .albumCarouselItem:
                  AlbumMediaRowItem(media: media)
               case .videoCarouselItem:
                  VideoMediaRow(media: media)
               default:
                  VideoMediaItem(media: media)
               }
            }
         }
         .padding(.top, topPadding)
         .padding(.horizontal)
         
         if playerObservableObject.showPlayerView, !playerObservableObject.expand { Spacer(minLength: Metric.playerHeight) }
      }
      .scrollingDisabled(scrollDisabled)
      .labeledViewModifier(header: !title.isEmpty ? title : nil)
   }
   
   private func setupGridSpacing(_ spacing: CGFloat?, defaultSpace: CGFloat) {
      if let spacing = spacing {
         gridSpacing = spacing
      } else {
         gridSpacing = defaultSpace
      }
   }
}


// MARK: - Previews

struct VerticalMediaGridView_Previews: PreviewProvider {
   static var previews: some View {
      VStack {
         VerticalMediaGridView(mediaItems: musicPlaylists2, title: "You Gotta Hear This", imageSize: .trackRowItem)
            .environmentObject(PlayerObservableObject())
      }
   }
}
