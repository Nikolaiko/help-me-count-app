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
