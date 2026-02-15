//
//  DBRepeatableAction.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 11.02.2026.
//

import Foundation
import SwiftData

@Model
final class DBRepeatableAction {

    @Attribute(.unique)
    var id: UUID

    @Attribute(.unique)
    var title: String

    @Attribute(.unique)
    var maxRepeats: Int

    @Attribute(.unique)
    var currentRepeats: Int

    init(id: UUID, title: String, maxRepeats: Int, currentRepeats: Int) {
        self.id = id
        self.title = title
        self.maxRepeats = maxRepeats
        self.currentRepeats = currentRepeats
    }
}

