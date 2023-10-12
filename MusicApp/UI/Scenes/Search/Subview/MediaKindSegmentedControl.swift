//
//  MediaKindSegmentedControl.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.03.2023.
//

import SwiftUI

struct MediaKindSegmentedControl: View {
   @ObservedObject var searchModel: SearchViewModel
   @Namespace var animation
   
   var body: some View {
      ScrollViewReader { proxy in
         ScrollView(.horizontal, showsIndicators: false) {
            HStack {
               ForEach(Array(zip(MediaType.allCases.indices, MediaType.allCases)), id: \.0) { index, mediaType in
                  
                  mediaKindItem(for: mediaType)
                     .id(index)
               }
            }
            .padding(.horizontal)
         }
         .onChange(of: searchModel.selectedMediaType) { _, newValue in
            withAnimation {
               proxy.scrollTo(newValue, anchor: .center)
            }
         }
      }
      .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8), value: searchModel.selectedMediaType)
   }
   
   @ViewBuilder
   func mediaKindItem(for mediaType: MediaType) -> some View {
      Button(action: {
         withAnimation {
            searchModel.select(mediaType)
         }
      }) {
         Text(mediaType.title)
            .font(.footnote.weight(.medium))
            .padding(.vertical, 8)
            .padding(.horizontal)
         
            .background {
               if searchModel.selectedMediaType == mediaType {
                  Capsule()
                     .fill(Color.accentColor)
                     .matchedGeometryEffect(id: "TAB", in: animation)
               }
            }
            .foregroundStyle(searchModel.selectedMediaType == mediaType ? .white : Color.primary)
      }
   }
}

// MARK: - Previews

struct MediaKindSegmentedControl_Previews: PreviewProvider {
   static var previews: some View {
      MediaKindSegmentedControl(searchModel: SearchViewModel())
         .environmentObject(PlayerModel())
   }
}
