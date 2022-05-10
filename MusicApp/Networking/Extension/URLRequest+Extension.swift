//
//  URLRequest+Extension.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import Foundation

extension URLRequest {
    func print() {
        let url = url?.absoluteString ?? ""
        var message = "\(httpMethod ?? "???"): \(url)"
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            message += "\n\tbody: \(body)"
        }
        debugPrint(message)
    }
}
