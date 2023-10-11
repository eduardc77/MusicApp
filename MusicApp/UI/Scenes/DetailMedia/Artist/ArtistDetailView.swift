//
//  ArtistDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI
import AVKit

struct ArtistDetailView: View {
   @Environment(\.dismiss) private var dismiss
   @EnvironmentObject private var playerModel: PlayerModel
   @StateObject private var artistViewModel: ArtistViewModel
   @State private var navigationHidden: Bool = true
   
   private var artistDetailSections: [ArtistDetailSection] = ArtistDetailSection.allCases
   
   let media: Media
   
   init(media: Media) {
      self.media = media
      _artistViewModel = StateObject(wrappedValue: ArtistViewModel(media: media))
   }
   
   var body: some View {
      ZStack {
         if !artistViewModel.loadingComplete {
            LoadingView()
         } else {
            ScrollView(.vertical, showsIndicators: false) {
               
               if let recentAlbum = artistViewModel.albums.first {
                  ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                     ParallaxHeaderView(
                        coordinateSpace: CoordinateSpace.global,
                        height: 400
                     ) {
                        MediaImageView(imagePath: recentAlbum.artworkPath.resizedPath(size: 400))
                     }
                     
                     Text(media.artistName)
                        .padding()
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                  }
                  .toolbar(navigationHidden ? .hidden : .visible, for: .navigationBar)
                  .navigationTitle(media.artistName)
                  .navigationBarTitleDisplayMode(.inline)

                  .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                        Button { } label: {
                           Image(systemName: "ellipsis")
                              .font(.footnote)
                        }
                     }
                  }
                  .background(
                     GeometryReader { proxy in
                        Color.clear.preference(
                           key: ScrollViewOffsetPreferenceKey.self,
                           value: -proxy.frame(in: .named(CoordinateSpace.global)).origin.y
                        )
                     }
                  )
               }
               
               VStack(spacing: 30) {
                  ForEach(artistDetailSections, id: \.self) { section in
                     switch section {
                        case .featuredAlbum:
                           if let featureAlbum = artistViewModel.artistFeatureAlbum {
                              NavigationLink(destination:
                                                AlbumDetailView(media: featureAlbum)) {
                                 ArtistFeaturedAlbumRow(media: featureAlbum, action: {
                                    
                                 })
                              }
                              .padding(.top, 26)
                           }
                        case .topSongs:
                           if !artistViewModel.tracks.isEmpty {
                              HorizontalMediaGridView(mediaItems: artistViewModel.tracks, title: section.title, imageSize: .trackRowItem, rowCount: 4, scrollBehavior: .paging)
                           }
                        case .albums:
                           if !artistViewModel.albums.isEmpty {
                              HorizontalMediaGridView(mediaItems: artistViewModel.albums, title: section.title, imageSize: .albumCarouselItem)
                           }
                        case .musicVideos:
                           if !artistViewModel.musicVideos.isEmpty {
                              HorizontalMediaGridView(mediaItems: artistViewModel.musicVideos, title: section.title, imageSize: .videoCarouselItem)
                           }
                        case .singlesAndEps:
                           if !artistViewModel.singlesAndEps.isEmpty {
                              HorizontalMediaGridView(mediaItems: artistViewModel.singlesAndEps, title: section.title, imageSize: .albumCarouselItem)
                           }
                        case .appearsOn:
                           if !artistViewModel.appearsOn.isEmpty {
                              HorizontalMediaGridView(mediaItems: artistViewModel.appearsOn, title: section.title, imageSize: .albumCarouselItem)
                           }
                     }
                  }
                  
                  if playerModel.showPlayerView, !playerModel.expand { Spacer(minLength: Metric.playerHeight) }
               }
               .background()
            }
            .coordinateSpace(name: CoordinateSpace.global)
            .ignoresSafeArea(edges: artistViewModel.artistFeatureAlbum != nil ? .top : .init())
            
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
               guard value >= 0 else {
                  navigationHidden = true
                  return
               }
               navigationHidden = value > Metric.mediaPreviewHeaderHeight ? false : true
            }
            .overlay { if artistViewModel.artistFeatureAlbum != nil { topNavigationControls } }
         }
      }
      
      .errorAlert(errorState: $artistViewModel.errorState) {
         artistViewModel.fetchAllArtistMedia(for: media.id)
      } cancel: { dismiss() }
   }
   
   private var artistVideoPreviewUrls: [URL]? {
      let artistMusicVideos = artistViewModel.musicVideos.filter { $0.artistName == media.artistName }
      var artistVideoPreviewUrls = [URL]()
      
      artistMusicVideos.prefix(3).forEach { musicVideo in
         artistVideoPreviewUrls.append(musicVideo.previewUrl)
      }
      
      return artistVideoPreviewUrls
   }
   
   // MARK: - Subviews
   
   @ViewBuilder
   private var topNavigationControls: some View {
      ZStack(alignment: .top) {
         HStack {
            Button { dismiss() } label: {
               Image(systemName: "chevron.left.circle.fill")
                  .resizable()
                  .frame(width: 26, height: 26)
                  .foregroundStyle(.white, .black.opacity(0.2))
            }
            
            Spacer()
            
            Button { } label: {
               Image(systemName: "ellipsis.circle.fill")
                  .resizable()
                  .frame(width: 26, height: 26)
                  .foregroundStyle(.white, .black.opacity(0.2))
            }
         }
      }
      .padding(.horizontal, 12)
      .opacity(navigationHidden ? 1 : 0)
      .offset(y: -Metric.mediaPreviewHeaderHeight + 12)
   }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
   typealias Value = CGFloat
   static var defaultValue = CGFloat.zero
   
   static func reduce(value _: inout Value, nextValue: () -> Value) {
      _ = nextValue()
   }
}


// MARK: - Previews

struct ArtistDetailView_Previews: PreviewProvider {
   static var previews: some View {
      ArtistDetailView(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerModel())
   }
}
