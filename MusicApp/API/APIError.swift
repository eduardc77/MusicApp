//
//  APIError.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

enum APIError: Error, LocalizedError {
    case urlRequest
    case network
    case server
    case generic
    
    var errorDescription: String? {
        switch self {
        case .urlRequest:
            return "The request could not be completed."
        case .network:
            return
                """
                We could not connect to the network. \
                Please check your internet connection, or try again later.
                """
        case .server:
            return "We could not connect to the server."
        case .generic:
            return "Something went wrong. Please try again later."
        }
    }
}
