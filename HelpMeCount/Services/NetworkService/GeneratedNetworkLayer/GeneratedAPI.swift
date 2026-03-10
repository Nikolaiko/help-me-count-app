//
//  GeneratedAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct GeneratedAPI: NetworkService {
    func loginUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        let loginString = "\(login):\(password)"

        guard let loginData = loginString.data(using: .utf8)
        else { return .failure(.client) }

        let base64LoginString = loginData.base64EncodedString()
        let headers = ["Authorization" : "Basic \(base64LoginString)"]

        let apiConf = OpenAPIClientAPIConfiguration(customHeaders: headers)
        do {
            let response = try await AuthorizationAPI.login(apiConfiguration: apiConf)
            return .success(response.toUserToken())
        } catch {
            return .failure(error.toNetworkError())
        }
    }
    
    func registerUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        let request = AuthRequest(username: login, password: password)
        do {
            let response = try await AuthorizationAPI.register(authRequest: request)
            return .success(response.toUserToken())
        } catch {
            return .failure(error.toNetworkError())
        }
    }

    func addNewAction() {
        ActionsAPI.addAction()
    }
}
