//
//  TopImageView.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

struct MediaPreviewHeader: View {
  let imagePath: String
  
  var body: some View {
    GeometryReader { proxy in
      if proxy.frame(in: .global).minY > -Metric.mediaPreviewHeaderHeight {
        MediaImageView(imagePath: imagePath.resizedPath(size: 600), contentMode: .fill)
          .offset(y: offsetY(proxy: proxy))
          .frame(width: Metric.screenWidth, height: parallaxHeight(proxy: proxy))
      }
    }
    .frame(height: Metric.mediaPreviewHeaderHeight)
  }
}

private extension MediaPreviewHeader {
  func offsetY(proxy: GeometryProxy) -> CGFloat {
    -proxy.frame(in: .global).minY
  }
  
  func parallaxHeight(proxy: GeometryProxy) -> CGFloat {
    proxy.frame(in: .global).minY > 0 ? proxy.frame(in: .global).minY + Metric.mediaPreviewHeaderHeight : Metric.mediaPreviewHeaderHeight
  }
}


// MARK: - Previews

struct MediaPreviewHeader_Previews: PreviewProvider {
	struct MediaPreviewHeaderExample: View {
		@State var playing: Bool = false

		var body: some View {
			MediaPreviewHeader(imagePath: musicPlaylists2.first?.artworkPath ?? "http://is2.mzstatic.com/image/thumb/Music3/v4/13/ae/73/13ae735e-33d0-1480-f51b-4150d4a45696/source/60x60bb.jpg")
				.padding()
		}
	}

	static var previews: some View {
		MediaPreviewHeaderExample()
	}
}

