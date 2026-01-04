//
//  AuthResponse.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.01.2026.
//

import Foundation

struct AuthResponse: Decodable {
    let token: String
    let refreshToken: String
}
