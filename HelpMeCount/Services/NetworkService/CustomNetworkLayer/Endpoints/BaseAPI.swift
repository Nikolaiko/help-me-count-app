//
//  BaseAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

enum HTTPRequestType: String {
    case get = "GET"
    case post = "POST"
}

protocol URLConvertible {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var port: Int? { get }
    var body: Data? { get }
    var urlQuery: [String : String] { get }
    var headers: [String : String] { get }
    var method: HTTPRequestType { get }
}

extension URLConvertible {
    var schema: String { "http" }
    var host: String { "e97b67a8bc6.vps.myjino.ru" }
    var port: Int? { 49235 }
    var method: HTTPRequestType { .get }
    var urlQuery: [String : String] { [:] }
    var headers: [String : String] { [:] }

    func asRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = schema
        components.host = host
        components.path = path
        components.port = port
        components.queryItems = urlQuery.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else { throw NetworkError.genericNetworkError }

        var request = URLRequest(url: url)
        request.httpBody = body
        request.httpMethod = method.rawValue
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        return request
    }
}

