//
//  CategoryGridView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 19.04.2022.
//

import SwiftUI

struct CategoryGridView: View {
	@EnvironmentObject private var playerObservableObject: PlayerObservableObject
	@State var categories = searchCategories
	var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

	var body: some View {
		LazyVGrid(columns: columns) {
			ForEach(categories, id: \.self) { category in
				NavigationLink(destination: CategoryDetailView(category: category)) {
					ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
						MediaImageView(artworkImage: UIImage(named: category.image),
											sizeType: .categoryCollectionRow,
											contentMode: .fill)

						Text(category.title)
							.padding(10)
							.foregroundColor(.white)
							.font(.callout.bold())
					}
				}
			}
		}
		.padding(.horizontal)
		.labeledViewModifier(header: "Browse Categories", spacing: 6)

		if playerObservableObject.showPlayerView, !playerObservableObject.expand {
			Spacer(minLength: Metric.playerHeight)
		}
	}
}


// MARK: - Previews

struct CategoryGridView_Previews: PreviewProvider {
	static var previews: some View {
		CategoryGridView()
			.environmentObject(PlayerObservableObject())
	}
}
