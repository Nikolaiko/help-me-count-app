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
        case let .error(status, _, _, urlError):
            if status == 403 { return .tokenExpired }

            if let sessionError = urlError as? URLError,
               sessionError.code == URLError.notConnectedToInternet ||
                sessionError.code == URLError.networkConnectionLost
            { return .noInternet }

            return .genericNetworkError
        }
    }
}

extension NewCountableAction {
    func toNewRepeatableAction() -> NewRepeatableAction {
        NewRepeatableAction(title: title, maxRepeats: maxRepeats, currentRepeats: currentRepeats)
    }
}

extension RepeatableAction {
    func toCountableAction() -> CountableAction {
        CountableAction(id: id, title: title, maxRepeats: maxRepeats, currentRepeats: currentRepeats)
    }
}

extension CountableAction {
    func toDBAction() -> DBCountableAction {
        DBCountableAction(id: id, title: title, maxRepeats: maxRepeats, currentRepeats: currentRepeats)
    }
}

extension DBCountableAction {
    func toCountableAction() -> CountableAction {
        CountableAction(id: id, title: title, maxRepeats: maxRepeats, currentRepeats: currentRepeats)
    }
}
