//
//  GeneratedAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct GeneratedAPI: NetworkService {
    func loginUser(login: String, password: String) async -> APIAuthResponse? {
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return nil }
        let base64LoginString = loginData.base64EncodedString()
        let headers = ["Authorization" : "Basic \(base64LoginString)"]

        let apiConf = OpenAPIClientAPIConfiguration(customHeaders: headers)
        guard let response = try? await AuthorizationAPI.login(apiConfiguration: apiConf)
        else { return nil }

        return APIAuthResponse(token: response.token, refreshToken: response.refreshToken)
    }
    
    func registerUser(login: String, password: String) async -> APIAuthResponse? {
        let request = AuthRequest(username: login, password: password)
        guard let response = try? await AuthorizationAPI.register(authRequest: request)
        else { return nil }

        return APIAuthResponse(token: response.token, refreshToken: response.refreshToken)
    }
}
