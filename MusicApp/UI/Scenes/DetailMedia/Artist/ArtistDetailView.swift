//
//  ArtistDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct ArtistDetailView: View {
   @Environment(\.dismiss) private var dismiss
   @EnvironmentObject private var playerModel: PlayerModel
   @StateObject private var artistViewModel: ArtistViewModel
   private var artistDetailSections: [ArtistDetailSection] = ArtistDetailSection.allCases
   @State var isFavorite: Bool = false
   @State var scrollOffset = CGFloat.zero
   @State var scrollSafeAreaInset = CGFloat.zero
   @Namespace var scrollSpace
   let media: Media
   private var topPadding: CGFloat = 20
   
   private var navigationHidden: Bool {
      scrollOffset + (scrollSafeAreaInset / 2) + topPadding < Metric.mediaPreviewHeaderHeight
   }
   
   init(media: Media) {
      self.media = media
      _artistViewModel = StateObject(wrappedValue: ArtistViewModel(media: media))
   }
   
   var body: some View {
      Group {
         if !artistViewModel.loadingComplete {
            LoadingView()
         } else {
            GeometryReader { geometry in
               ObservableScrollView(scrollSpace: scrollSpace, scrollOffset: $scrollOffset) {
                  VStack(spacing: 0) {
                     artistPreviewHeader(scrollSafeAreaInset: scrollSafeAreaInset)
                     artistGalleryList
                  }
               }
               .navigationTitle(media.artistName)
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                  ToolbarItemGroup(placement: .topBarTrailing) {
                     HStack(spacing: 14) {
                        FavoriteButton(backgroundColor: isFavorite ? Color(uiColor: .tertiarySystemGroupedBackground) : .secondaryButtonBackgroundColor,
                                       isFavorite: $isFavorite) {}
                        ToolbarButton(title: "Menu",
                                      iconName: "ellipsis",
                                      font: .title2) {}
                     }
                  }
               }
               .toolbar(navigationHidden ? (artistViewModel.artistFeatureAlbum != nil ? .hidden : .automatic) : .automatic, for: .navigationBar)
               .animation(.default, value: navigationHidden)
               .ignoresSafeArea(edges: artistViewModel.artistFeatureAlbum != nil ? .top : .init())
               .overlay { if artistViewModel.artistFeatureAlbum != nil { topNavigationControls } }

               
               .onAppear {
                  scrollSafeAreaInset = geometry.safeAreaInsets.top
               }
            }
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
}

// MARK: - Subviews

private extension ArtistDetailView {
   var topNavigationControls: some View {
      ZStack(alignment: .top) {
         HStack {
            ToolbarButton(title: "Back",
                          iconName: "chevron.left",
                          font: .title,
                          foregroundColor: .white,
                          backgroundColor: .secondary) { dismiss() }
            Spacer()
            HStack(spacing: 12) {
               FavoriteButton(foregroundColor: .white,
                              backgroundColor: .secondary,
                              isFavorite: $isFavorite) {}
               
               ToolbarButton(title: "Menu",
                             iconName: "ellipsis",
                             font: .title,
                             foregroundColor: .white,
                             backgroundColor: .secondary) {}
            }
         }
      }
      .padding(.leading, 6)
      .padding(.trailing, 16)
      .opacity(navigationHidden ? 1 : 0)
      .offset(y: -Metric.mediaPreviewHeaderHeight + (topPadding * 2))
   }
   
   func artistPreviewHeader(scrollSafeAreaInset: CGFloat) -> some View {
      let size = Metric.mediaPreviewHeaderHeight
      let minY = -scrollOffset + scrollSafeAreaInset - topPadding
      let progress = minY / (size * 0.9)
      
      return ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
         if let recentAlbum = artistViewModel.albums.first {
            ParallaxHeaderView(
               coordinateSpace: scrollSpace,
               height: Metric.mediaPreviewHeaderHeight
            ) {
               MediaImageView(imagePath: recentAlbum.artworkPath.resizedPath(size: Int(Metric.mediaPreviewHeaderHeight)))
            }
            Rectangle()
               .fill(.linearGradient(colors: (0...5).map { Color.black.opacity(Double($0) * 0.1 - (progress / 2)) }, startPoint: .top, endPoint: .bottom))
         }
         
         HStack {
            Text(media.artistName)
               .foregroundStyle(artistViewModel.albums.first != nil ? .white : .primary)
               .font(.largeTitle.bold())
              
            Spacer()
            ToolbarButton(title: "Play",
                          iconName: "play",
                          font: .largeTitle,
                          foregroundColor: .white,
                          backgroundColor: .accentColor) {}
         }
         .padding(.bottom)
         .padding(.horizontal)
      }
   }
   
   var artistGalleryList: some View {
      VStack(spacing: 30) {
         ForEach(artistDetailSections, id: \.self) { section in
            switch section {
               case .featuredAlbum:
                  if let featureAlbum = artistViewModel.artistFeatureAlbum {
                     NavigationLink(destination: AlbumDetailView(media: featureAlbum)) {
                        ArtistFeaturedAlbumRow(media: featureAlbum) { }
                     }
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
      .padding(.top, topPadding)
      .background()
      
   }
}

// MARK: - Previews

struct ArtistDetailView_Previews: PreviewProvider {
   static var previews: some View {
      ArtistDetailView(media: musicPlaylists2.first ?? Media())
         .environmentObject(PlayerModel())
   }
}
