//
//  NetworkError.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

enum NetworkError: Error {
    case genericNetworkError
    case wrongStatus
    case server
    case client
    case tokenExpired
}
