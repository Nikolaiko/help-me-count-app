//
//  GeneratedAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct GeneratedAPI: NetworkService {
    func registerRequest(login: String, password: String) async -> TokenData? {
        let authRequest = AuthRequest(username: login, password: password)
        guard let response = try? await AuthorizationAPI.register(authRequest: authRequest)
        else { return nil }

        return TokenData.fromAuthResponse(response: response)
    }
    
    func loginRequest(login: String, password: String) async -> TokenData? {
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return nil }
        let base64LoginString = loginData.base64EncodedString()

        var config = OpenAPIClientAPIConfiguration()
        config.customHeaders = ["Authorization" : "Basic \(base64LoginString)"]

        guard let response = try? await AuthorizationAPI.login(apiConfiguration: config)
        else { return nil }

        return TokenData.fromAuthResponse(response: response)
    }
    
    func getAllActions(token: String) async -> [CountableAction] {
        []
    }
}
