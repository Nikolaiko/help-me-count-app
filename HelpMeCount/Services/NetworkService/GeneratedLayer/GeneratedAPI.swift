//
//  GeneratedAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct GeneratedAPI: NetworkService {
    let localStorage: LocalDataStorage

    init(localStorage: LocalDataStorage) {
        self.localStorage = localStorage
    }

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
    
    func getAllActions() async -> [CountableAction] {
        guard let tokenData = await localStorage.getLoggedUser()
        else { return [] }

        let config = buildBearerHeader(token: tokenData.token)
        let actions: [RepeatableAction]
        do {
            actions = try await ActionsAPI.getAllActions(apiConfiguration: config)
        } catch {
            if isTokenExpiredError(error: error) {
                if let newTokens = await tryToRefreshToken(refreshToken: tokenData.refreshToken) {

                    let actionsConfig = buildBearerHeader(token: newTokens.token)
                    actions = (try? await ActionsAPI.getAllActions(apiConfiguration: actionsConfig)) ?? []
                } else { actions = [] }
            } else { actions = [] }
        }
        return actions.map { $0.toCountableAction() }
    }

    func addAction(newAction: NewCountableAction) async -> CountableAction? {
        guard let tokenData = await localStorage.getLoggedUser()
        else { return nil }

        let headerConfig = buildBearerHeader(token: tokenData.token)
        let addedAction = try? await ActionsAPI.addAction(
            newRepeatableAction: newAction.toRepeatableAction(),
            apiConfiguration: headerConfig
        )
        return addedAction?.toCountableAction()
    }

    private func tryToRefreshToken(refreshToken: String) async -> TokenData? {
        let refreshConfig = buildBearerHeader(token: refreshToken)
        guard let refreshResponse = try? await AuthorizationAPI.refresh(apiConfiguration: refreshConfig)
        else { return nil }

        let newData = TokenData.fromAuthResponse(response: refreshResponse)
        return await localStorage.saveLoggedUser(newData)
    }

    private func isTokenExpiredError(error: ErrorResponse) -> Bool {
        switch error {
        case .error(let status, _, _, _):
            if status == 403 { return true }
        }
        return false
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
