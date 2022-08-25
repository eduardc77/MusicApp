//
//  ImageLoader.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import SwiftUI

public protocol ImageLoaderProtocol {
  func fetchImage(from path: String) async throws -> UIImage?
}

public final class ImageLoader: ImageLoaderProtocol {
  private let session: URLSession
  
  private var cache: URLCache? {
    session.configuration.urlCache
  }
  
  public init(session: URLSession = .session) {
    self.session = session
  }
  
  public func fetchImage(from path: String) async throws -> UIImage? {
    guard let url = URL(string: path) else {
      throw NetworkError.invalidURL
    }
    
    let request = URLRequest(url: url)
    guard let data = cache?.cachedResponse(for: request)?.data, let image = UIImage(data: data) else {
      //            request.print()
      
      return try await loadAndCacheImage(with: request)
    }
    return image
  }
}

private extension ImageLoader {
  func loadAndCacheImage(with request: URLRequest) async throws -> UIImage? {
    do {
      let (data, response) = try await session.data(for: request)
      guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else { return nil }
      
      let cachedData = CachedURLResponse(response: response, data: data)
      cache?.storeCachedResponse(cachedData, for: request)
      
      return UIImage(data: data)
    } catch {
      throw NetworkError.imageLoadingError
    }
  }
}

