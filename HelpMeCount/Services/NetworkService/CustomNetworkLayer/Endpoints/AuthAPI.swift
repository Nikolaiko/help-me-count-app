//
//  AuthAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

enum AuthAPI: URLConvertible {
    case login(login: String, password: String)
    case register(login: String, password: String)

    var method: HTTPRequestType { .post }

    var path: String {
        switch self {
        case .login:
            "/authorization/login"
        case .register:
            "/authorization/register"
        }
    }

    var body: Data? {
        switch self {
        case .register(let username, let password):
            let request = APIAuthRequest(username: username, password: password)
            guard let request = try? JSONEncoder().encode(request) else { return  nil }
            return request
        default:
            return nil
        }
    }

    var headers: [String: String] {
        switch self {
        case .login(let username, let password):
            let loginString = "\(username):\(password)"
            guard let loginData = loginString.data(using: .utf8) else { return [:] }
            let base64LoginString = loginData.base64EncodedString()
            return ["Authorization" : "Basic \(base64LoginString)"]
        default:
            return [:]
        }
    }
}
