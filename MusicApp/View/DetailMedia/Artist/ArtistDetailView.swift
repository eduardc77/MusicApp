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
  @EnvironmentObject private var playerObservableObject: PlayerObservableObject
  @StateObject private var artistObservableObject: ArtistViewObservableObject
  @State var navigationHidden: Bool = true
  
  let media: Media
  
  init(media: Media) {
    self.media = media
    _artistObservableObject = StateObject(wrappedValue: ArtistViewObservableObject(media: media))
  }
  
  var body: some View {
    ZStack {
      if !artistObservableObject.loadingComplete {
        LoadingView()
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          Group {
            if let recentAlbum = artistObservableObject.albums.first {
              ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                MediaPreviewHeader(imagePath: recentAlbum.artworkPath)
                
                Text(media.artistName)
                  .padding(12)
                  .foregroundColor(.white)
                  .font(.largeTitle.bold())
              }
              .navigationTitle(navigationHidden ? "" : media.artistName)
              .navigationBarHidden(navigationHidden).animation(.default, value: navigationHidden)
              
              .background(
                GeometryReader { proxy in
                  Color.clear.preference(
                    key: ScrollViewOffsetPreferenceKey.self,
                    value: -1 * proxy.frame(in: .named("scroll")).origin.y
                  )
                }
              )
              
              VStack {
                NavigationLink(destination: AlbumDetailView(media: recentAlbum, searchObservableObject: SearchObservableObject())) {
                  MediumMediaRow(media: recentAlbum, action: {})
                    .padding(.top)
                }
                
                if !artistObservableObject.tracks.isEmpty {
                  HorizontalMediaGridView(mediaItems: artistObservableObject.tracks, title: "Top Songs", imageSize: .trackRowItem, rowCount: 4)
                    .padding(.top)
                }
                
                if !artistObservableObject.albums.isEmpty {
                  HorizontalMediaGridView(mediaItems: artistObservableObject.albums, title: "Albums", imageSize: .albumCarouselItem)
                }
                
                if !artistObservableObject.musicVideos.isEmpty {
                  HorizontalMediaGridView(mediaItems: artistObservableObject.musicVideos, title: "Music Videos", imageSize: .videoCarouselItem)
                }
                
                if !artistObservableObject.singlesAndEps.isEmpty {
                  HorizontalMediaGridView(mediaItems: artistObservableObject.singlesAndEps, title: "Singles & EPs", imageSize: .albumCarouselItem)
                }
                
                if !artistObservableObject.appearsOn.isEmpty {
                  HorizontalMediaGridView(mediaItems: artistObservableObject.appearsOn, title: "Appears On", imageSize: .albumCarouselItem)
                }
              }
              .background()
              
              if playerObservableObject.showPlayerView, !playerObservableObject.expand {
                Spacer(minLength: Metric.playerHeight)
              }
            }
          }
          
          
          .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            guard value > 0 else { return }
            navigationHidden = value > Metric.mediaPreviewHeaderHeight - 36 ? false : true
          }
        }
        .coordinateSpace(name: "scroll")
        
        .overlay {
          ZStack(alignment: .top) {
            HStack {
              Button { dismiss() } label: {
                Image(systemName: "chevron.left.circle.fill")
                  .resizable()
                  .frame(width: 26, height: 26)
                  .foregroundStyle(.white, .black.opacity(0.4))
              }
              
              Spacer()
              
              Button { } label: {
                Image(systemName: "ellipsis.circle.fill")
                  .resizable()
                  .frame(width: 26, height: 26)
                  .foregroundStyle(.white, .black.opacity(0.4))
              }
            }
          }
          .padding(.horizontal, 12)
          .opacity(navigationHidden ? 1 : 0)
          .offset(y: -Metric.mediaPreviewHeaderHeight + 16)
        }
      }
    }
    .onAppear {
      artistObservableObject.fetchAllArtistMedia(for: media.id)
    }
    
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button { } label: {
          Image(systemName: "ellipsis")
            .font(.footnote)
        }
      }
    }
    
    .errorAlert(errorState: $artistObservableObject.errorState) {
      artistObservableObject.fetchAllArtistMedia(for: media.id)
      
    } cancel: {
      dismiss()
    }
  }
  
  var artistVideoPreviewUrls: [URL]? {
    let artistMusicVideos = artistObservableObject.musicVideos.filter { $0.artistName == media.artistName }
    var artistVideoPreviewUrls = [URL]()
    
    artistMusicVideos.prefix(3).forEach { musicVideo in
      artistVideoPreviewUrls.append(musicVideo.previewUrl)
    }
    
    return artistVideoPreviewUrls
  }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  typealias Value = CGFloat
  static var defaultValue = CGFloat.zero
  
  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}
