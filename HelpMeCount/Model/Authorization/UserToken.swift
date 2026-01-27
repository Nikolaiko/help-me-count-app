//
//  UserToken.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import Foundation

struct UserToken: Codable {
    let token: String
    let refreshToken: String
}
