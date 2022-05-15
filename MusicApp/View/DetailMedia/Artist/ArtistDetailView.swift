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
            if !artistObservableObject.loadingComplete {
                ProgressView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    if let media = artistObservableObject.albumResults.first {
                        TopImageView(imagePath: artistObservableObject.albumResults[1].artworkPath)
                        
                        VStack {
                            HorizontalMediaGridView(mediaItems: artistObservableObject.songs, title: "Top Songs", imageSize: .small, rowCount: 4)
                                .padding(.top)
                            
                            HorizontalMediaGridView(mediaItems: artistObservableObject.albums, title: "Albums", imageSize: .medium)
                            
                            HorizontalMediaGridView(mediaItems: artistObservableObject.musicVideos, title: "Music Videos", imageSize: .large)
                            
                        
                        }
                        .background()
                    }
                }
            }
        }
        .task {
            artistObservableObject.fetchAllArtistMedia(for: mediaId)
        }
        
        .errorAlert(errorState: $artistObservableObject.errorState) {
            artistObservableObject.fetchAllArtistMedia(for: mediaId)
        } cancel: { dismiss() }
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


// MARK: - Preview

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailView(mediaId: "455832983")
    }
}
