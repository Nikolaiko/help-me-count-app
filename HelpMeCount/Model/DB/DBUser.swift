//
//  DBUser.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.01.2026.
//

import Foundation
import SwiftData

@Model
final class DBUser {

    @Attribute(.unique)
    var id: UUID

    @Attribute(.unique)
    var login: String

    @Attribute(.unique)
    var token: String

    @Attribute(.unique)
    var refreshToken: String

    init(id: UUID, login: String, token: String, refreshToken: String) {
        self.id = id
        self.login = login
        self.token = token
        self.refreshToken = refreshToken
    }
}
