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
   
   @State var activeTab: MediaType = .topResult
   
   var body: some View {
      ScrollViewReader { proxy in
         ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
               ForEach(MediaType.allCases, id: \.self) { mediaType in
                  
                  mediaKindItem(for: mediaType)
                     .id(mediaType)
               }
            }
            .padding(.horizontal)
         }
         .onChange(of: searchModel.selectedMediaType) { _, newValue in
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)) {
               activeTab = newValue
            }
            withAnimation {
               proxy.scrollTo(newValue, anchor: .center)
            }
         }
      }
   }
   
   @ViewBuilder
   func mediaKindItem(for mediaType: MediaType) -> some View {
      Button(action: {
         searchModel.select(mediaType)
      }) {
         Text(mediaType.title)
            .font(.footnote.weight(.medium))
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
         
            .background {
               if activeTab == mediaType {
                  Capsule()
                     .fill(Color.accentColor)
                     .matchedGeometryEffect(id: "TAB", in: animation)
               }
            }
            .foregroundStyle(activeTab == mediaType ? .white : Color.primary)
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
