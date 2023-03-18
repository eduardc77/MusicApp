//
//  MediaKindSegmentedControl.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.03.2023.
//

import SwiftUI

struct MediaKindSegmentedControl: View {
  @ObservedObject var searchObservableObject: SearchObservableObject
  @State var selectedMediaKind: MediaType = .topResult
  @Namespace var animation

  var body: some View {
	 ScrollView(.horizontal, showsIndicators: false) {
		HStack {
		  ForEach(MediaType.allCases, id: \.self) { mediaKind in
			 Button(action: {
				withAnimation {
				  searchObservableObject.select(mediaKind)
				  selectedMediaKind = mediaKind
				}
			 }) {
				Text(mediaKind.title)
				  .font(.footnote.weight(.medium))
				  .padding(.vertical, 8)
				  .padding(.horizontal)
				  .background(
					 ZStack {
						if selectedMediaKind == mediaKind {
						  Capsule()
							 .fill(Color.appAccentColor)
							 .matchedGeometryEffect(id: "TAB", in: animation)
						}
					 }
				  )
				  .foregroundColor(selectedMediaKind == mediaKind ? .white : .primary)
			 }
			 .buttonStyle(.plain)
		  }
		}
		.padding(.horizontal)
	 }
  }
}
