//
//  DBUser.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation
import SwiftData

@Model
final class DBToken {

    @Attribute(.unique)
    var token: String

    init(token: String) {
        self.token = token
    }
}
