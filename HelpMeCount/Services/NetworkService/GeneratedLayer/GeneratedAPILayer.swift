//
//  GeneratedAPILayer.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 25.02.2026.
//

import Foundation

struct GeneratedAPILayer {

    func makeRequest<T: Codable>(requestClosure: () async throws(ErrorResponse) -> T) async -> Result<T, NetworkErrors> {
        do {
            let result = try await requestClosure()
            return .success(result)
        } catch {
            switch error {
            case let .error(status, data, response, urlError):
                if status == 403 { return .failure(.tokenExpired) }
                guard let sessionError = urlError as? URLError,
                      sessionError.code == URLError.networkConnectionLost ||
                      sessionError.code == URLError.notConnectedToInternet
                else { return .failure(.networkError) }
                return .failure(.noConnection)
            }
        }
    }

    private func tryToRefreshToken(refreshToken: String) async -> TokenData? {
        let refreshConfig = buildBearerHeader(token: refreshToken)
        guard let refreshResponse = try? await AuthorizationAPI.refresh(apiConfiguration: refreshConfig)
        else { return nil }

        let newData = TokenData.fromAuthResponse(response: refreshResponse)
        return await localStorage.saveLoggedUser(newData)
    }
}
