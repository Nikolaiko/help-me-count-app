//
//  CountableAction.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.10.2025.
//

import Foundation

struct CountableAction: Identifiable, Codable {
    let id: Int
    let title: String
    let maxRepeates: Int
    let currentRepeats: Int
}

extension CountableAction {
    func toRepeatableAction() -> UserRepeatableAction {
        .init(id: id, title: title, maxRepeates: maxRepeates, currentRepeats: currentRepeats)
    }
}
