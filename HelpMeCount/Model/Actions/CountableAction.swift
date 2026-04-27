//
//  CountableAction.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 10.03.2026.
//

import Foundation

struct CountableAction: Codable {
    let id: UUID
    let title: String
    let  maxRepeats: Int
    let  currentRepeats: Int
}
