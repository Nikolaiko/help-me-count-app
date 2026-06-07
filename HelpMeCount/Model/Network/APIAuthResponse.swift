//
//  AuthResponse.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 05.01.2026.
//

import Foundation

struct APIAuthResponse: Decodable {
    let token: String
    let refreshToken: String
}
