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
    
    let mediaId: String
    
    var body: some View {
        ZStack {
            if artistObservableObject.isLoading {
                ProgressView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    if let media = artistObservableObject.albumResults.first {
                        TopImageView(imagePath: artistObservableObject.albumResults[1].artworkPath)
                        
                        VStack {
                            HorizontalMediaGridView(mediaItems: artistObservableObject.songs, title: "Top Songs", imageSize: .small, rowCount: 4)
                                .padding(.top)
                            
                            HorizontalMediaGridView(mediaItems: artistObservableObject.albums, title: "Albums", imageSize: .medium)
                            
                            VStack(alignment: .center, spacing: 0) {
                                infoView(for: media)
                                isCollectionView(for: media)
                            }
                        }
                        .background()
                    }
                }
            }
        }
        .task {
            artistObservableObject.fetchArtistAlbums(for: mediaId)
            artistObservableObject.fetchArtistSongs(for: mediaId)
        }
        
        .errorAlert(errorState: $artistObservableObject.errorState) {
            artistObservableObject.fetchArtistAlbums(for: mediaId)
            artistObservableObject.fetchArtistSongs(for: mediaId)
        } cancel: { dismiss() }
    }
}

// MARK: - Subviews

private extension ArtistDetailView {
    @ViewBuilder
    func isCollectionView(for media: Media) -> some View {
        Divider()
            .padding()
        trailerView(for: media)
        Divider()
            .padding()
        descriptionView(for: media)
    }
    
    func buttonsView(for media: Media) -> some View {
        HStack {
            Link(destination: media.itunesLink) {
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
    
    func infoView(for media: Media) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Short information")
                .detailTitle
            //            ForEach(media.shortInfo) { mediaType in
            //                info(for: mediaType, media: media)
            //            }
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
    
    func trailerView(for media: Media) -> some View {
        VStack(alignment: .leading) {
            Text("Watch trailer")
                .detailTitle
            VideoPlayer(player: AVPlayer(url: media.trailerLink))
                .frame(width: Metric.screenWidth * 0.92, height: 250)
                .cornerRadius(10)
        }
    }
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


// MARK: - Preview

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailView(mediaId: "455832983")
    }
}
