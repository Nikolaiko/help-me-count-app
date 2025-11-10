//
//  NetworkErrors.swift
//  TrainingSessions
//
//  Created by Nikolai Baklanov on 24.10.2025.
//

import Foundation

enum NetworkErrors: Error {
    case wrongStatus
    case emptyData
    case networkError
}
