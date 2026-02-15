//
//  Version2.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.02.2026.
//

import Foundation
import SwiftData

enum Version2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [DBUserToken.self, DBRepeatableAction.self]
    }
}
