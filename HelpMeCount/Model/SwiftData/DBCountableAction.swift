//
//  DBCountableAction.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.03.2026.
//

import Foundation
import SwiftData

@Model
final class DBCountableAction {

    @Attribute(.unique)
    var id: UUID

    @Attribute
    var title: String

    @Attribute
    var  maxRepeats: Int

    @Attribute
    var  currentRepeats: Int

    init(id: UUID, title: String, maxRepeats: Int, currentRepeats: Int) {
        self.id = id
        self.title = title
        self.maxRepeats = maxRepeats
        self.currentRepeats = currentRepeats
    }
}
