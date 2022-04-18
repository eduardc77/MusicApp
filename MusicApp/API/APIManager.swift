//
//  APIManager.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 18.04.2022.
//

import Foundation

struct APIManager<Response>: APIRequest {
    var path: Path
    var urlSession: URLSession
}
