//
//  ActionOperationError.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import Foundation

enum ActionOperationError: Error {
    case noLoggedTokenFound



    var title: String {
        switch self {
        case .noLoggedTokenFound:
            return "No logged token"
        }
    }
}
