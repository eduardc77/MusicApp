//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
	@StateObject private var mediaImageObservableObject: MediaImageObservableObject
	@Binding private var visibleSide: FlipViewSide
	@Binding var playing: Bool
	@State var animate: Bool = false
	var selected: Bool = false
	private let imagePath: String?
	private var artworkImage: UIImage?
	private var sizeType: SizeType
	private var cornerRadius: CGFloat
	private var shadowProminence: ShadowProminence
	private var contentMode: ContentMode
	private var foregroundColor: Color

	init(imagePath: String? = nil, artworkImage: UIImage? = nil, sizeType: SizeType = .defaultSize, cornerRadius: CGFloat = Metric.defaultCornerRadius, shadowProminence: ShadowProminence = .none, contentMode: ContentMode = .fit, foregroundColor: Color = .secondary.opacity(0.1), visibleSide: Binding<FlipViewSide> = .constant(.front), selected: Bool = false, playing: Binding<Bool> = .constant(false)) {
		_mediaImageObservableObject = StateObject(wrappedValue: MediaImageObservableObject())
		_visibleSide = visibleSide
		_playing = playing
		self.selected = selected
		self.imagePath = imagePath
		self.artworkImage = artworkImage
		self.sizeType = sizeType
		self.cornerRadius = cornerRadius
		self.shadowProminence = shadowProminence
		self.contentMode = contentMode
		self.foregroundColor = foregroundColor
	}

	var body: some View {
		FlipView(visibleSide: visibleSide) {
			Group {
				if let uiImage = mediaImageObservableObject.image {
					Image(uiImage: uiImage).resizable()
				} else if let artworkImage = artworkImage, let artwork = Image(uiImage: artworkImage) {
					artwork.resizable()
				}
				else {
					ZStack {
						Group {
							switch sizeType {
							case .artistRow:
								Circle()
									.fill(foregroundColor)
									.frame(width: sizeType.size.width, height: sizeType.size.height)
									.cornerRadius(cornerRadius)
									.overlay { Circle().stroke(.secondary.opacity(0.8), lineWidth: 0.1) }

								Image(systemName: "music.mic")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.foregroundColor(Color.secondary)
									.frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2)
							default:
								Rectangle()
									.fill(foregroundColor)
									.frame(width: sizeType.size.width, height: sizeType.size.height)
									.cornerRadius(cornerRadius)
									.overlay { RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.secondary.opacity(0.8), lineWidth: 0.1) }

								Image("music-note")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.foregroundColor(Color.secondary.opacity(0.3))
									.frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6)
							}
						}
					}
				}
			}
			.aspectRatio(contentMode: contentMode)
			.contentShape(Rectangle())
			.frame(width: sizeType.size.width, height: sizeType.size.height)
			.cornerRadius(cornerRadius)

			.overlay {
				ZStack {
					if selected {
						Color.gray.opacity(0.6)

						NowPlayingEqualizerBars(animating: $playing, color: .white)
							.frame(width: 16, height: 8)

					}
					RoundedRectangle(cornerRadius: cornerRadius)
						.stroke(Color.secondary.opacity(0.6), lineWidth: 0.1)
				}
			}
		} back: {
			ZStack {
				Rectangle().fill(Color(.lightGray))
					.frame(width: sizeType.size.width, height: sizeType.size.height)
					.cornerRadius(cornerRadius)

				Image("music-note")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.foregroundColor(.secondary)
					.frame(width: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6, height: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 1.6)
			}
		}
		.shadow(radius: shadowProminence.shadow.radius, x: shadowProminence.shadow.xPosition, y: shadowProminence.shadow.yPosition)
		.animation(.flipCard, value: visibleSide)

		.task {
			guard let imagePath = imagePath else { return }
			await mediaImageObservableObject.fetchImage(from: imagePath)
		}
	}
}

// MARK: - Types

extension MediaImageView {
	enum ShadowProminence {
		case none
		case mild
		case full

		var shadow: (radius: CGFloat, xPosition: CGFloat, yPosition: CGFloat) {
			switch self {
			case .none:
				return (radius: 0, xPosition: 0, yPosition: 0)
			case .mild:
				return (radius: 2, xPosition: 0, yPosition: 0)
			case .full:
				return (radius: 16, xPosition: 3, yPosition: 3)
			}
		}
	}
}


// MARK: - Previews

struct MediaImageView_Previews: PreviewProvider {
	struct MediaImageViewExample: View {
		@State private var visibleSide = FlipViewSide.front

		var body: some View {
			MediaImageView(artworkImage: UIImage(named: "p0"), sizeType: .albumDetail, shadowProminence: .full, visibleSide: $visibleSide)
		}
	}
	static var previews: some View {
		MediaImageViewExample()
	}
}
