//
//  Endpoint.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

public enum ResponseType {
	case lookup(id: String, country: String? = nil, entity: String? = nil, media: String? = nil, attribute: String? = nil, limit: String? = nil, sort: String? = nil, explicit: String? = nil)
	case search(term: String, country: String? = nil, entity: String? = nil, media: String? = nil, attribute: String? = nil, limit: String? = nil, sort: String? = nil, explicit: String? = nil)
}

public struct Endpoint {
	let path: String
	let queryItems: [URLQueryItem]
}

public extension Endpoint {
	static func getInfo(by responseType: ResponseType) -> Endpoint {
		switch responseType {
		case let .lookup(id, country, entity, media, attribute, limit, sort, explicit):
			return Endpoint(
				path: "/lookup",
				queryItems: [
					URLQueryItem(name: "id", value: id),
					URLQueryItem(name: "country", value: country),
					URLQueryItem(name: "entity", value: entity),
					URLQueryItem(name: "media", value: media),
					URLQueryItem(name: "attribute", value: attribute),
					URLQueryItem(name: "limit", value: limit),
					URLQueryItem(name: "sort", value: sort),
					URLQueryItem(name: "explicit", value: explicit)
				]
			)
		case let .search(term, country, entity, media, attribute, limit, sort, explicit):
			return Endpoint(
				path: "/search",
				queryItems: [
					URLQueryItem(name: "term", value: term),
					URLQueryItem(name: "country", value: country),
					URLQueryItem(name: "entity", value: entity),
					URLQueryItem(name: "media", value: media),
					URLQueryItem(name: "attribute", value: attribute),
					URLQueryItem(name: "limit", value: limit),
					URLQueryItem(name: "sort", value: sort),
					URLQueryItem(name: "explicit", value: explicit)
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
