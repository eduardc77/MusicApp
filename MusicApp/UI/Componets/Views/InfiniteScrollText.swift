//
//  InfiniteScrollText.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 20.05.2022.
//

import SwiftUI

struct InfiniteScrollText: View {
	@State var text: String
	var explicitness: Explicitness = .notExplicit
	var textColor: Color = .white.opacity(0.9)
	var animationSpeed: Double = 0.03
	var delayTime: Double = 3.33
	var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
	var spacing: CGFloat = 30

	var body: some View {
		VStack(spacing: 0) {
			if text.size(withFont: font).width > Metric.screenWidth / 1.6 {
				infiniteScrollText
					.mask {
						HStack(spacing: 0) {
							Spacer()
							LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.6), .black]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
								.frame(width: spacing)

							LinearGradient(gradient: Gradient(colors: [.black]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)

							LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.6), .black].reversed()), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
								.frame(width: spacing)
							Spacer()
						}
					}
			} else {
				MediaItemName(name: text, explicitness: explicitness, font: Font(font), imageFont: Font(UIFont.boldSystemFont(ofSize: 16)), foregroundColor: textColor, spacing: 4)
					.padding(.leading, spacing)
			}
		}
		.frame(height: text.size(withFont: font).height)
	}

	private var infiniteScrollText: some View {
		return GeometryReader { geoReader in
			InfiniteCarousel(animationDuration: animationSpeed * text.size(withFont: font).width,
								  animationDelay: delayTime,
								  scrollingDirection: .left,
								  contentSize: text.size(withFont: font),
								  spacing: spacing,
								  explicitText: explicitness) {
				MediaItemName(name: text, explicitness: explicitness, font: Font(font), imageFont: Font(UIFont.boldSystemFont(ofSize: 16)), foregroundColor: textColor, spacing: 4)
					.padding(.leading, spacing)
			}
		}
	}
}


// MARK: - Previews

struct MarqueeText_Previews: PreviewProvider {
	static var previews: some View {
		GeometryReader { geoReader in
			InfiniteCarousel(animationDuration: 0.03 * geoReader.size.width,
								  scrollingDirection: .left,
								  contentSize: geoReader.size,
								  spacing: 0) {
				HStack(spacing: 0) {
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
						.frame(width: geoReader.size.width)
				}
				.frame(maxWidth: .infinity)
			}
		}
	}
}
