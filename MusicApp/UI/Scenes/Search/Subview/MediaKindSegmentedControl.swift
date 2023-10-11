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
                  .id(index)
                  
                  .onChange(of: searchModel.selectedMediaType) { _, newValue in
                     if newValue == mediaType {
                        withAnimation {
                           proxy.scrollTo(index, anchor: .center)
                        }
                     }
                  }
               }
            }
            .padding(.horizontal)
         }
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
