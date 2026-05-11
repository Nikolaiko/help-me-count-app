//
//  RequestExecutor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.05.2026.
//


import Foundation

class RequestLocalExecutor {

    private let localService: LocalTokensStorage

    init(localService: LocalTokensStorage) {
        self.localService = localService
    }

    func makeRequest<T>(request: () async throws(ErrorResponse) -> T) async throws(NetworkError) -> T {
        try await execute(request: request)
    }

    private func execute<T>(request: () async throws(ErrorResponse) -> T) async throws(NetworkError) -> T {
        do {
            let result = try await request()
            return result
        } catch {
            print(error)
            let networkError = error.toNetworkError()
            switch networkError {
            case .tokenExpired:
                if await tryToRefreshToken() {
                    if let result = try? await request() { return result }
                    else { throw .failedDuringRefreshToken }
                } else { throw .failedDuringRefreshToken }
            default:
                throw networkError
            }
        }
    }

    private func tryToRefreshToken() async -> Bool {
        guard let token = localService.getUserToken()
        else { return false }

        let config = buildBearerHeader(token: token.refreshToken)
        guard let newToken = try? await AuthorizationAPI.refresh(apiConfiguration: config),
              let _ = localService.saveUserToken(newToken: newToken.toUserToken())
        else { return false }
        return true
    }

    private func buildBearerHeader(token: String?) -> OpenAPIClientAPIConfiguration {
        let headers: [String: String] = ["Authorization" : "Bearer \(token ?? "")"]
        return OpenAPIClientAPIConfiguration(basePath: GeneratedLocalAPI.baseAddress, customHeaders: headers)
    }
}
