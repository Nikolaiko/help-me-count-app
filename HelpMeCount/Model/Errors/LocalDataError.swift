//
//  LocalDataError.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 03.02.2026.
//

import Foundation

enum LocalDataError: Error {
    case failedToCreateStorage
    case failedToSaveEntity
}
