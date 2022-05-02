//
//  MediaDetailView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI
import AVKit

struct MediaDetailView: View {
    var media: Media?
    var imageData: Data?

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(media?.trackName ?? "Not Playing")
                        .font(.headline).bold()
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    if let previewUrl = media?.previewUrl {
                        VideoPlayer(player: AVPlayer(url: previewUrl))
                            .frame(width: proxy.size.width - 32, height: 250)
                            .padding([.bottom], 8)
                        detailsForVideo
                    } else {
                        HStack(spacing: 40) {
                            mediaImage
                            mediaImageDetails
                        }
                    }

                    Divider()

                    Text("Description")
                        .font(.headline)
                        .padding([.top, .bottom], 8)

                    Text(media?.description ?? "")
                        .padding([.bottom], 16)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .padding()
            }
            
        }
    }

    var mediaImageDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Price: ").bold() +
            Text(media?.trackPrice != nil ? "$\(media?.trackPrice ?? 0)" : "No Price")

            if #available(iOS 15.0, *) {
                Text("Published: ").bold() +
                Text(media?.releaseDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
            } else {
                Text("Published: ").bold() +
                Text(media?.releaseDate?.mediumDateStyle ?? "")
            }
            
            genres
        }
    }

    var detailsForVideo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()

            HStack(spacing: 10) {
                Text("Price: ").bold() +
                Text(media?.trackPrice != nil ? "$\(media?.trackPrice ?? 0)" : "No Price")

                if #available(iOS 15.0, *) {
                    Text("Published: ").bold() +
                    Text(media?.releaseDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
                } else {
                    Text("Published: ").bold() +
                    Text(media?.releaseDate?.mediumDateStyle ?? "")
                }
            }

            genres
        }
        .padding([.top], 8)
    }

    @ViewBuilder
    var mediaImage: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            MediaImageView(image:Image(uiImage: uiImage))
        } else {
            MediaImageView()
        }
    }

    var genres: some View {
        Text("Genre(s): ").bold() +
        Text(media?.primaryGenreName ?? "No Genre")
    }
}
