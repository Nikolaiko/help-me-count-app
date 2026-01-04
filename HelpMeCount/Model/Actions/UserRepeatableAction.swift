//
//  UserRepeatableAction.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import Foundation

struct UserRepeatableAction: Identifiable, Codable {
    let id: Int
    let title: String
    let maxRepeates: Int
    let currentRepeats: Int
}

