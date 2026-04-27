//
//  UserDefaultsStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import Foundation

struct UserDefaultsStorage: LocalTokensStorage {
    private let keyName = "logged_user"

    func getUserToken() -> UserToken? {
        guard let data = UserDefaults.standard.data(forKey: keyName),
              let token = try? JSONDecoder().decode(UserToken.self, from: data)
        else { return nil }
        return token
    }
    
    func saveUserToken(newToken: UserToken) -> UserToken? {
        guard let encodedData = try? JSONEncoder().encode(newToken)
        else { return nil }

        UserDefaults.standard.setValue(encodedData, forKey: keyName)
        return newToken
    }
    

}
