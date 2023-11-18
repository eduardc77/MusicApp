//
//  AsyncImage.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 08.01.2023.
//

import SwiftUI

struct AsyncImageView: View {
   let url: URL
   let sizeType: SizeType
   
   var body: some View {
      VStack {
         CacheAsyncImage(url: url, sizeType: sizeType) { phase in
            switch phase {
            case .success(let image):
               image
                  .resizable()
                  .frame(width: sizeType.size.width, height: sizeType.size.height)
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
}

private struct CacheAsyncImage<Content>: View where Content: View {
   let url: URL
   let sizeType: SizeType
   let content: (AsyncImagePhase) -> Content
   
   init(
      url: URL,
      sizeType: SizeType,
      @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
   ) {
      self.url = url
      self.sizeType = sizeType
      
      self.content = content
   }
   
   var body: some View {
      if let cached = ImageCache[url] {
         content(.success(cached))
      } else {
         AsyncImage(url: url) { phase in
            cacheAndRender(phase: phase)
         }
      }
   }
   
   func cacheAndRender(phase: AsyncImagePhase) -> some View {
      if case .success(let image) = phase {
         ImageCache[url] = image
      }
      
      return content(phase)
   }
}

private class ImageCache {
   static private var cache: [URL: Image] = [:]
   
   static subscript(url: URL) -> Image? {
      get {
         ImageCache.cache[url]
      }
      set {
         ImageCache.cache[url] = newValue
      }
   }
}
