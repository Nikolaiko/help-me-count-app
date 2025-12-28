//
//  MockBackend.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.12.2025.
//

import Foundation

struct MockBackend: NetworkService {
    func registerRequest(login: String, password: String) async -> UserToken? {
        try? await Task.sleep(nanoseconds: 2_000_000)
        return UserToken(token: "1234", refreshToken: "5678")
    }
    
    func loginRequest(login: String, password: String) async -> UserToken? {
        try? await Task.sleep(nanoseconds: 2_000_000)
        return UserToken(token: "1234", refreshToken: "5678")
    }
    

}
