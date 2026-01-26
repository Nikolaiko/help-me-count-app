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
        let config = buildBasicAuthHeader(login: login, password: password)
        guard let response = try? await AuthorizationAPI.login(apiConfiguration: config)
        else { return nil }

        return TokenData.fromAuthResponse(response: response)
    }
    
    func getAllActions(token: String) async -> [CountableAction] {
        let config = buildBearerHeader(token: token)
        let actions = try? await ActionsAPI.getAllActions(apiConfiguration: config)
        return actions?.map { $0.toCountableAction() } ?? []
    }

    func addAction(token: String, newAction: NewCountableAction) async -> CountableAction? {
        let headerConfig = buildBearerHeader(token: token)
        let addedAction = try? await ActionsAPI.addAction(
            newRepeatableAction: newAction.toRepeatableAction(),
            apiConfiguration: headerConfig
        )
        return addedAction?.toCountableAction()
    }

    private func buildBearerHeader(token: String) -> OpenAPIClientAPIConfiguration {
        let config = OpenAPIClientAPIConfiguration()
        config.customHeaders = ["Authorization" : "Bearer \(token)"]
        return config
    }

    private func buildBasicAuthHeader(login: String, password: String) -> OpenAPIClientAPIConfiguration {
        let loginString = "\(login):\(password)"

        guard let loginData = loginString.data(using: .utf8)
        else { return OpenAPIClientAPIConfiguration.shared }

        let base64LoginString = loginData.base64EncodedString()
        let config = OpenAPIClientAPIConfiguration()
        config.customHeaders = ["Authorization" : "Basic \(base64LoginString)"]
        return config
    }
}
