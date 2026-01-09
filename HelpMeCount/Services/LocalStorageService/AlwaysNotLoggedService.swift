//
//  AlwaysNotLoggedService.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

struct AlwaysNotLoggedService: LocalStorageService {
    func getUserToken() -> String? {
        nil
    }

    func saveUserToken(newToken: String) -> String? {
        nil
    }
}
