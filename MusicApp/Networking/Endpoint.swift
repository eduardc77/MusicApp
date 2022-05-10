//
//  Endpoint.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

public enum ResponseType {
    case detail(id: String, entity: String)
    case search(term: String, country: String, entity: String, media: String)
}

public struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

public extension Endpoint {
    static func getInfo(by responseType: ResponseType) -> Endpoint {
        switch responseType {
        case let .detail(id, entity):
            return Endpoint(
                path: "/lookup",
                queryItems: [
                    URLQueryItem(name: "id", value: id),
                    URLQueryItem(name: "entity", value: entity),
                ]
            )
        case let .search(term, country, entity, media):
            return Endpoint(
                path: "/search",
                queryItems: [
                    URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "country", value: country),
                    URLQueryItem(name: "entity", value: entity),
                    URLQueryItem(name: "media", value: media),
                ]
            )
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
