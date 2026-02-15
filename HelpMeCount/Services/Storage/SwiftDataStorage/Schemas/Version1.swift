//
//  Version1.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.02.2026.
//

import Foundation
import SwiftData

enum Version1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [DBUserToken.self]
    }
}
