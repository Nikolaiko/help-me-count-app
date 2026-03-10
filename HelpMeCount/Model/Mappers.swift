//
//  Mappers.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import Foundation

extension AuthResponse {
    func toUserToken() -> UserToken {
        UserToken(token: token, refreshToken: refreshToken)
    }
}

extension APIAuthResponse {
    func toUserToken() -> UserToken {
        UserToken(token: token, refreshToken: refreshToken)
    }
}

extension ErrorResponse {
    func toNetworkError() -> NetworkError {
        switch self {
        case let .error(status, data, response, urlError):
            if status == 403 { return .tokenExpired }
            else { return .genericNetworkError }
        }
    }
}
