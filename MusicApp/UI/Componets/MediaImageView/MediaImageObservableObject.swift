//
//  MediaImageObservableObject.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

@MainActor
final class MediaImageObservableObject: ObservableObject {
  private let dataLoader: ImageLoaderProtocol
  
  @Published private(set) var image: UIImage?
  
  init(dataLoader: ImageLoaderProtocol = ImageLoader()) {
    self.dataLoader = dataLoader
  }
  
  func fetchImage(from path: String) async {
    image = try? await dataLoader.fetchImage(from: path)
  }
}
