//
//  Migrations.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.02.2026.
//

import Foundation
import SwiftData

enum Migrations: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [Version1.self, Version2.self]
    }

    static var stages: [MigrationStage] {
        [
            .lightweight(fromVersion: Version1.self, toVersion: Version2.self)
        ]
    }
}
