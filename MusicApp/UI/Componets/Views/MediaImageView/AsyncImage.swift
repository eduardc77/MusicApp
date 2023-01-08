//
//  AsyncImage.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 08.01.2023.
//

import SwiftUI

struct AsyncImageView: View {
	let urlString: String
	let sizeType: SizeType

	var body: some View {
		AsyncImage(url: URL(string: urlString)) { phase in
			switch phase {
			case .success(let image):
				image.resizable()
			case .empty:
				DefaultImage(sizeType: sizeType)
			case .failure(_):
				DefaultImage(sizeType: sizeType)
			@unknown default:
				Color.clear
			}
		}
	}
}
