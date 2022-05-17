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
    
    @StateObject private var artistObservableObject = ArtistViewObservableObject()
    
    let media: Media
    @State var navigationHidden: Bool = true
    
    var body: some View {
        ZStack {
            if !artistObservableObject.loadingComplete {
                LoadingView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if let recentAlbum = artistObservableObject.albums.first {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                if let videoAssetUrl = artistObservableObject.musicVideos.first?.previewUrl {
                                    VideoHeaderImageView(videoAssetUrl: videoAssetUrl)
                                } else {
                                    HeaderImageView(imagePath: recentAlbum.artworkPath)
                                }
                                
                                Text(media.artistName)
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .font(.largeTitle.bold())
                            }
                            
                            VStack {
                                MediumMediaRow(media: recentAlbum, action: {})
                                    .padding(.top)
                                HorizontalMediaGridView(mediaItems: artistObservableObject.songs, title: "Top Songs", imageSize: .small, rowCount: 4)
                                    .padding(.top)
                                
                                HorizontalMediaGridView(mediaItems: artistObservableObject.albums, title: "Albums", imageSize: .medium)
                                
                                HorizontalMediaGridView(mediaItems: artistObservableObject.musicVideos, title: "Music Videos", imageSize: .large)
                            }
                            .background()
                            
                            Spacer(minLength: Metric.playerHeight)
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear.preference(
                                key: ScrollViewOffsetPreferenceKey.self.self,
                                value: -1 * proxy.frame(in: .named("scroll")).origin.y
                            )
                        }
                    )
                    .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                        navigationHidden = value > 180 ? false : true
                    }
                    
                }
                .coordinateSpace(name: "scroll")
                .navigationBarHidden(navigationHidden)
                .navigationTitle(media.artistName)
            }
        }
        .onAppear {
            artistObservableObject.fetchAllArtistMedia(for: media.id)
        }
        
        .errorAlert(errorState: $artistObservableObject.errorState) {
            artistObservableObject.fetchAllArtistMedia(for: media.id)
            
        } cancel: {
            dismiss()
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

// MARK: - Subviews

private extension ArtistDetailView {
    
    
    func buttonsView(for media: Media) -> some View {
        HStack {
            Link(destination: media.iTunesUrl) {
                Label("Itunes", systemImage: "applelogo")
                    .padding(.vertical, 2)
                    .padding(.horizontal, 5)
                    .foregroundColor(.gray)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundColor(
                                Color(.systemPink))) }
            Text(media.country)
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundColor(Color.secondary)
                )
                .foregroundColor(Color.secondary)
                .padding(.leading, 2)
            Spacer()
        }
        .padding([.horizontal, .bottom])
    }
    
    func descriptionView(for media: Media) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Description")
                .detailTitle
            Text(media.description)
                .fontWeight(.light).font(.system(size: 14))
                .foregroundColor(.primary)
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
    
    
    
    //    func info(for type: Media.ShortInfoType, media: Media) -> some View {
    //        HStack(spacing: 0) {
    //            Text(type.rawValue)
    //                .fontWeight(.light)
    //                .foregroundColor(.secondary)
    //            Spacer()
    //            Text(type.title(for: media))
    //                .fontWeight(.light)
    //                .font(.system(size: 14))
    //        }
    //    }
    
}

// MARK: - Private extensions

private struct DetailTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light))
            .foregroundColor(.primary)
            .padding(.bottom, 5)
    }
}

private extension View {
    var detailTitle: some View {
        modifier(DetailTitle())
    }
}
