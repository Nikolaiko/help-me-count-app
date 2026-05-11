//
//  Version1.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 06.05.2026.
//
import SwiftData

enum Version1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [DBCountableAction.self]
    }

    static var versionIdentifier = Schema.Version(1, 0, 0)
}
