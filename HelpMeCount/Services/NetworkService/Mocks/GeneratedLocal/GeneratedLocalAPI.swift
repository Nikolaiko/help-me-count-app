//
//  GeneratedAPI.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.05.2026.
//


import Foundation

struct GeneratedLocalAPI: NetworkService {

    public static let baseAddress = "http://127.0.0.1:8080"

    private let localService: LocalTokensStorage
    private let requestExcutor: RequestLocalExecutor

    init(localService: LocalTokensStorage) {
        self.localService = localService
        self.requestExcutor = RequestLocalExecutor(localService: localService)
    }

    // MARK: Authorization Requests

    func loginUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        let loginString = "\(login):\(password)"

        guard let loginData = loginString.data(using: .utf8)
        else { return .failure(.client) }

        let base64LoginString = loginData.base64EncodedString()
        let headers = ["Authorization" : "Basic \(base64LoginString)"]

        let apiConf = OpenAPIClientAPIConfiguration(
            basePath: GeneratedLocalAPI.baseAddress,
            customHeaders: headers
        )
        do {
            let response = try await AuthorizationAPI.login(apiConfiguration: apiConf)
            return .success(response.toUserToken())
        } catch {
            return .failure(error.toNetworkError())
        }
    }

    func registerUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        let request = AuthRequest(username: login, password: password)
        let apiConf = OpenAPIClientAPIConfiguration(
            basePath: GeneratedLocalAPI.baseAddress
        )
        do {
            let response = try await AuthorizationAPI.register(authRequest: request, apiConfiguration: apiConf)
            return .success(response.toUserToken())
        } catch {
            return .failure(error.toNetworkError())
        }
    }

    // MARK: Action requests

    func addNewAction(action: NewCountableAction) async -> Result<CountableAction, NetworkError> {
        let requestClosure: () async throws(ErrorResponse) -> RepeatableAction = {
            let token = localService.getUserToken()
            let config = buildBearerHeader(token: token?.token)

            return try await ActionsAPI.addAction(
                newRepeatableAction: action.toNewRepeatableAction(),
                apiConfiguration: config)
        }

        do {
            let result = try await requestExcutor.makeRequest(request: requestClosure)
            return .success(result.toCountableAction())
        } catch {
            return .failure(error)
        }
    }

    func getActions() async -> Result<[CountableAction], NetworkError> {
        let requestClosure: () async throws(ErrorResponse) -> [RepeatableAction] = {
            let token = localService.getUserToken()
            let config = buildBearerHeader(token: token?.token)

            return try await ActionsAPI.getAllActions(apiConfiguration: config)
        }

        do {
            let result = try await requestExcutor.makeRequest(request: requestClosure)
            return .success(result.map { $0.toCountableAction() })
        } catch {
            return .failure(error)
        }
    }

    func increaseActionCount(action: CountableAction) async -> Result<CountableAction, NetworkError> {
        let requestClosure: () async throws(ErrorResponse) -> RepeatableAction = {
            let token = localService.getUserToken()
            let config = buildBearerHeader(token: token?.token)
            let repeatableAction = RepeatableAction(
                id: action.id,
                title: action.title,
                maxRepeats: action.maxRepeats,
                currentRepeats: action.currentRepeats)

            print(repeatableAction)

            return try await ActionsAPI.editAction(actionid: repeatableAction.id,
                                                   repeatableAction: repeatableAction,
                                                   apiConfiguration: config)
        }
        do {
            let result = try await requestExcutor.makeRequest(request: requestClosure)
            return .success(result.toCountableAction())
        } catch {
            return .failure(error)
        }
    }

    // MARK: Private functions

    private func buildBearerHeader(token: String?) -> OpenAPIClientAPIConfiguration {
        let headers: [String: String] = ["Authorization" : "Bearer \(token ?? "")"]
        return OpenAPIClientAPIConfiguration(basePath: GeneratedLocalAPI.baseAddress, customHeaders: headers)
    }
}
