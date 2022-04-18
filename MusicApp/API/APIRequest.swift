//
//  APIRequest.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//


import Foundation
import Combine

protocol APIRequest {
    associatedtype Response

    var path: Path { get }
    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
}

// MARK: APIRequest default properties
extension APIRequest {
    var urlSession: URLSession { .shared }

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    var baseUrl: String {
        switch path {
        case .search:
            return "https://itunes.apple.com/search"
        case .lookup:
            return "https://itunes.apple.com/lookup"
        case .image(let url):
            return url.absoluteString
        }
    }
}

// MARK: APIRequest default methods
extension APIRequest {
    func makeUrlRequest() -> URLRequest? {
        guard var components = URLComponents(string: baseUrl) else {
            return nil
        }

        components.queryItems = path.queryToDictionary.map {
            URLQueryItem(name: $0.key , value: $0.value)
        }

        guard let url = components.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}

// MARK: APIRequest default methods where Response: Decodable
extension APIRequest where Response: Decodable {
    func send() -> AnyPublisher<Response, Error> {
        guard let urlRequest = makeUrlRequest() else {
            return Fail(error: APIError.urlRequest)
                .eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: urlRequest)
            .mapError { _ in APIError.network }
            .tryMap({ (data, response) in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw APIError.server
                }
                
                return data
            })
            .decode(type: Response.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: APIRequest for an image
extension APIRequest {
    func sendForImage() -> AnyPublisher<Data, Never> {
        guard let url = URL(string: baseUrl) else {
            return Just(Data()).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: Data())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
