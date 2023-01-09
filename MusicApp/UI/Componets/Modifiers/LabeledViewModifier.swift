//
//  LabeledViewModifier.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.01.2023.
//

import SwiftUI

struct LabeledViewModifier: ViewModifier {
	var mediaItems: [Media]
	var imageSize: SizeType
	var maxHighlightShowing: Int
	var header: String?
	var headerFont: Font
	var headerColor: Color
	var footer: String?
	var footerFont: Font
	var footerColor: Color
	var alignment: HorizontalAlignment
	var spacing: CGFloat

	func body(content: Content) -> some View {
		VStack(alignment: alignment, spacing: spacing) {
			Section {
				content

			} header: {
				if let title = header {
					Group {
						if mediaItems.count > maxHighlightShowing {
							NavigationLink {
								VerticalMediaGridView(mediaItems: mediaItems, imageSize: imageSize)
									.navigationTitle(title)
									.navigationBarTitleDisplayMode(.inline)

							} label: {
								HStack(spacing: 6) {
									Text(title)
										.font(headerFont)
										.foregroundColor(headerColor)

									Image(systemName: "chevron.forward")
										.font(.title3.bold())
										.foregroundColor(.secondary)
								}
								.frame(maxWidth: .infinity, alignment: .leading)
							}

						} else {
							Text(title)
								.font(headerFont)
								.foregroundColor(headerColor)
						}
					}
					.lineLimit(1)
					.padding(.horizontal)
				}

			} footer: {
				if let footer = footer {
					Text(footer)
						.font(footerFont)
						.foregroundColor(footerColor)
						.padding(.horizontal)
				}
			}
		}
	}
}

extension View {
	func labeledViewModifier(mediaItems: [Media] = [], imageSize: SizeType = .trackRowItem, maxHighlightShowing: Int = 0, header: String? = nil, headerFont: Font = .title2.bold(), headerColor: Color = .primary, footer: String? = nil, footerFont: Font = .caption, footerColor: Color = .secondary, alignment: HorizontalAlignment = .leading, spacing: CGFloat = 8) -> some View {
		self.modifier(LabeledViewModifier(mediaItems: mediaItems, imageSize: imageSize, maxHighlightShowing: maxHighlightShowing, header: header, headerFont: headerFont, headerColor: headerColor, footer: footer, footerFont: footerFont, footerColor: footerColor, alignment: alignment, spacing: spacing))
	}
}


// MARK: - Previews

struct LabeledViewModifier_Previews: PreviewProvider {
	static var previews: some View {
		VStack(alignment: .leading) {
			Divider()

			Group {
				Text("Item 1")
				Divider()
				Text("Item 2")
				Divider()
				Text("Item 3")
			}
			Divider()

		}
		.padding(.horizontal)
		.labeledViewModifier(header: "Top Songs", footer: "Footer")

	}
}

