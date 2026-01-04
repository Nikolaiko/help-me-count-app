//
//  DBUserToken.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.12.2025.
//

import Foundation
import SwiftData

@Model
final class DBUserToken {

    @Attribute(.unique)
    var token: String

    @Attribute(.unique)
    var refreshToken: String

    init(token: String, refreshToken: String) {
        self.token = token
        self.refreshToken = refreshToken
    }
}

