//
//  MediaImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

struct MediaImageView: View {
	@Binding private var visibleSide: FlipViewSide
	var selected: Bool = false
	private let imagePath: String?
	private var artworkImage: UIImage?
	private var sizeType: SizeType
	private var cornerRadius: CGFloat
	private var shadowProminence: ShadowProminence
	private var contentMode: ContentMode

	init(imagePath: String? = nil, artworkImage: UIImage? = nil, sizeType: SizeType = .defaultSize, cornerRadius: CGFloat = Metric.defaultCornerRadius, shadowProminence: ShadowProminence = .none, contentMode: ContentMode = .fit, visibleSide: Binding<FlipViewSide> = .constant(.front), selected: Bool = false) {
		_visibleSide = visibleSide
		self.selected = selected
		self.imagePath = imagePath
		self.artworkImage = artworkImage
		self.sizeType = sizeType
		self.cornerRadius = cornerRadius
		self.shadowProminence = shadowProminence
		self.contentMode = contentMode
	}

	var body: some View {
		FlipView(visibleSide: visibleSide) {
			Group {
				if let artworkImage = artworkImage, let artwork = Image(uiImage: artworkImage) {
					artwork.resizable()
				} else {
					AsyncImageView(urlString: imagePath ?? "", sizeType: sizeType)
				}
			}
			.aspectRatio(contentMode: contentMode)

			.overlay {
				if selected {
					ZStack {
						Color.gray.opacity(0.6)

						NowPlayingEqualizerBars(color: .white)
							.frame(width: 16, height: 8)
					}
				}
			}
			.overlay { RoundedRectangle(cornerRadius: cornerRadius).stroke(sizeType != .artistRow ? Color.secondary.opacity(0.8) : .clear, lineWidth: 0.1) }
			.clipShape(sizeType == .artistRow ? RoundedRectangle(cornerRadius: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2) : RoundedRectangle(cornerRadius: cornerRadius))

		} back: {
			DefaultImage(sizeType: sizeType)
				.overlay { RoundedRectangle(cornerRadius: cornerRadius).stroke(sizeType != .artistRow ? Color.secondary.opacity(0.8) : .clear, lineWidth: 0.1) }
				.clipShape(sizeType == .artistRow ? RoundedRectangle(cornerRadius: (sizeType.size.height ?? Metric.albumCarouselImageSize) / 2) : RoundedRectangle(cornerRadius: cornerRadius))
		}
		.frame(width: sizeType.size.width, height: sizeType.size.height)
		.shadow(radius: shadowProminence.shadow.radius, x: shadowProminence.shadow.xPosition, y: shadowProminence.shadow.yPosition)
		.animation(.flipCard, value: visibleSide)
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
			ZStack {
				Color.indigo

				MediaImageView(artworkImage: UIImage(named: "p0"), sizeType: .albumDetail, shadowProminence: .full, visibleSide: $visibleSide)
					.onTapGesture {
						visibleSide.toggle()
					}
			}
			.ignoresSafeArea()
		}
	}
	static var previews: some View {
		MediaImageViewExample()
	}
}

