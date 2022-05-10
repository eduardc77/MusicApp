//
//  DetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI
import AVKit

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
 
    @StateObject private var viewObservableObject = DetailViewObservableObject()
    
    let mediaId: String
    
    var body: some View {
        ZStack {
            if viewObservableObject.isLoading {
                loadingView
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewObservableObject.detailResults) { media in
                        ArtistPageView(imagePath: media.artworkPath)
                            .onTapGesture {
                                dismiss()
                            }
                        VStack(alignment: .center, spacing: 0) {
                            topView(for: media)
                            buttonsView(for: media)
                            infoView(for: media)
                            isCollectionView(for: media)
                        }
//                        .background(backgroundView)
                    }
                }
            }
        }
        .onAppear {
            viewObservableObject.fetchDetail(mediaId: mediaId)
        }
        .errorAlert(errorState: $viewObservableObject.errorState) {
            viewObservableObject.fetchDetail(mediaId: mediaId)
        } cancel: { dismiss() }
    }
}

// MARK: - Subviews

private extension DetailView {
    var loadingView: some View {
        VStack(spacing: 5) {
            ProgressView()
            Button(action: { dismiss() }) {
                Text("Cancel")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func isCollectionView(for media: Media) -> some View {
        Divider()
            .padding()
        trailerView(for: media)
        Divider()
            .padding()
        descriptionView(for: media)
    }
    
    func topView(for media: Media) -> some View {
        HStack(alignment: .top) {
            MediaImageView(imagePath: media.artworkPath.resizedPath(size: 200))
                .frame(width: 100, height: 150)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 4)
                        .shadow(color: .gray, radius: 2)
                )
                .offset(y: -50)
                .padding(.horizontal)
            VStack(alignment: .leading, spacing: 5) {
                Text(media.name)
                    .font(.title3)
                    .foregroundColor(.primary)
                Text(media.artistName)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top, .horizontal], 10)
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
        DetailView(mediaId: "455832983")
    }
}
