//
//  Mappers.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 19.01.2026.
//

import Foundation

extension TokenData {
    static func fromAuthResponse(response: AuthResponse) -> TokenData {
        TokenData(token: response.token, refreshToken: response.refreshToken)
    }
}

extension NewCountableAction {
    func toRepeatableAction() -> NewRepeatableAction {
        NewRepeatableAction(
            title: title,
            maxRepeats: maxRepeates,
            currentRepeats: currentRepeats)
    }
}

extension RepeatableAction {
    func toCountableAction() -> CountableAction {
        CountableAction(
            id: id,
            title: title,
            maxRepeates: maxRepeats,
            currentRepeats: currentRepeats)
    }
}
