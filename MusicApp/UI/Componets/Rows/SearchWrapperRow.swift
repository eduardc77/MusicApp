//
//  SearchCollectionRow.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 15.05.2022.
//

import SwiftUI

struct SearchWrapperRow<Content: View>: View {
	var media: Media
	var destinationView: Content
	
	var body: some View {
		NavigationLink(destination: destinationView) {
			HStack {
				switch media.wrapperType {
				case .collection:
					if let uiImage = media.artwork {
						MediaImageView(artworkImage: uiImage, sizeType: .searchRow)
					} else {
						MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .searchRow)
					}
					
					VStack(alignment: .leading) {
						MediaItemName(name: media.name, explicitness: media.collectionExplicitness, font: .callout)
						MediaItemName(name: "\(media.kind.title) · \(media.artistName)", font: .callout)
					}
					
				default:
					if let uiImage = media.artwork {
						MediaImageView(artworkImage: uiImage, sizeType: .artistRow)
							.clipShape(Circle())
						
					} else {
						MediaImageView(imagePath: media.artworkPath.resizedPath(size: 100), sizeType: .artistRow)
							.clipShape(Circle())
					}
					
					VStack(alignment: .leading) {
						MediaItemName(name: media.artistName, font: .callout)
						MediaItemName(name: "Artist", font: .callout)
					}
				}
				Spacer()
				
				Image(systemName: "chevron.right")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
		}
	}
}


// MARK: - Previews

struct SearchWrapperRow_Previews: PreviewProvider {
	struct SearchWrapperRowExample: View {
		let media = musicPlaylists2.first ?? Media()
		
		var body: some View {
			SearchWrapperRow(media: media, destinationView: ArtistDetailView(media: media))
				.environmentObject(PlayerObservableObject())
				.padding()
		}
	}
	
	static var previews: some View {
		SearchWrapperRowExample()
	}
}
