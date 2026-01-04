//
//  UserDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.01.2026.
//

import Foundation

struct UserDefaultsStorage: LocalDataStorage {
    private static let tokenKey = "token"

    private let userDefaults = UserDefaults.standard

    func getLoggedUser() -> TokenData? {
        guard let tokenData = userDefaults.data(forKey: UserDefaultsStorage.tokenKey),
              let token = try? JSONDecoder().decode(TokenData.self, from: tokenData)
        else { return nil }
        return token
    }
    
    func saveLoggedUser(_ token: TokenData) -> TokenData? {
        guard let encoded = try? JSONEncoder().encode(token)
        else { return nil }

        userDefaults.set(encoded, forKey: UserDefaultsStorage.tokenKey)
        return token
    }
}
