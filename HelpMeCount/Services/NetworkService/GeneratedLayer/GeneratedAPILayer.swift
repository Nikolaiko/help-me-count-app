//
//  GeneratedAPILayer.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 25.02.2026.
//

import Foundation

struct GeneratedAPILayer {

    private let localStorage: LocalDataStorage

    init(localStorage: LocalDataStorage) {
        self.localStorage = localStorage
    }

    func makeRequest<T: Codable>(requestClosure: () async throws(ErrorResponse) -> T) async -> Result<T, NetworkErrors> {

        let requestResult = await executeRequest(requestClosure)
        switch requestResult {
        case .success:
            return requestResult
        case .failure(let error):
            switch error {
            case .tokenExpired:
                guard await tryToRefreshToken() else { return requestResult }
                return await executeRequest(requestClosure)
            default:
                return requestResult
            }
        }
    }

    private func executeRequest<T: Codable>(_ requestClosure: () async throws(ErrorResponse) -> T) async -> Result<T, NetworkErrors> {
        do {
            let result = try await requestClosure()
            return .success(result)
        } catch {
            switch error {
            case let .error(status, data, response, urlError):
                if status == 403 { return.failure(.tokenExpired) }
                guard let sessionError = urlError as? URLError,
                      sessionError.code == URLError.networkConnectionLost ||
                      sessionError.code == URLError.notConnectedToInternet
                else { return .failure(.networkError) }
                return .failure(.noConnection)
            }
        }
    }

    private func tryToRefreshToken() async -> Bool {
        guard let refreshToken = await localStorage.getLoggedUser()?.refreshToken
        else { return false }

        let refreshConfig = buildBearerHeader(token: refreshToken)

        guard let refreshResponse = try? await AuthorizationAPI.refresh(apiConfiguration: refreshConfig)
        else { return false }

        let newData = TokenData.fromAuthResponse(response: refreshResponse)
        return await localStorage.saveLoggedUser(newData) != nil
    }

    private func buildBearerHeader(token: String?) -> OpenAPIClientAPIConfiguration {
        let config = OpenAPIClientAPIConfiguration()
        config.customHeaders = ["Authorization" : "Bearer \(token ?? "")"]
        return config
    }
}
