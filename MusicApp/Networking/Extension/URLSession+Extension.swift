//
//  URLSession+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import Foundation
import Combine

public extension URLSession {
    static var session: URLSession {
        let session = URLSession(configuration: .default)
        session.configuration.urlCache = .init(memoryCapacity: 0, diskCapacity: 200.toMb)
        return session
    }
    
    func networkingPublisher<T: Decodable>(for request: URLRequest, decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
