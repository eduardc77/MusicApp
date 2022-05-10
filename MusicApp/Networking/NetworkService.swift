//
//  NetworkService.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation
import Combine

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

public final class NetworkService: NetworkServiceProtocol {
    public init() {}
    
    public func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.session.networkingPublisher(for: makeRequest(url: url))
            .mapError(handleError)
            .eraseToAnyPublisher()
    }
}

private extension NetworkService {
    func handleError(_ error: Error) -> NetworkError {
        switch error {
        case let error as DecodingError:
            return .decodingError(error)
        case let error as NSError:
            switch error.code {
            case NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet:
                return .noInternetConnection
            default:
                return .unknownError
            }
        default:
            return .unknownError
        }
    }
    
    func makeRequest(url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        request.print()
        return request
    }
}
