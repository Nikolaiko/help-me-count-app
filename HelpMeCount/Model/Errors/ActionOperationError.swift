//
//  ActionOperationError.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import Foundation

enum ActionOperationError: Error {
    case noLoggedTokenFound
    case errorDuringRequest



    var title: String {
        switch self {
        case .noLoggedTokenFound:
            return "No logged token"
        case .errorDuringRequest:
            return "Error during request"
        }
    }
}
