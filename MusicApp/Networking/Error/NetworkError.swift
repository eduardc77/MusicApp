//
//  NetworkError.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

public enum NetworkError: Error {
  case invalidURL
  case imageLoadingError
  case emptyResponseData
  case noInternetConnection
  case unknownError
  case decodingError(DecodingError)
  
  public var errorTitle: String {
    switch self {
    case .invalidURL:
      return "URL error"
    case .imageLoadingError:
      return "Image loading error"
    case .emptyResponseData:
      return "Response data missing"
    case .noInternetConnection:
      return "Internet connection error"
    case .unknownError:
      return "Error"
    case .decodingError:
      return "Decoding error"
    }
  }
  
  public var localizedDescription: String {
    switch self {
    case .invalidURL:
      return "Invalid URL"
    case .imageLoadingError:
      return "Image loading error"
    case .emptyResponseData:
      return "Error: empty lookup data"
    case .noInternetConnection:
      return "No internet connection"
    case .unknownError:
      return "Unknown error occurred."
    case let .decodingError(error):
      return "Enable to parse data: " + error.localizedDescription.lowercased()
    }
  }
}
