//
//  APILayer.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct APILayer: NetworkService {
    private let transportLayer = TransportLayer()
    private let decoder = JSONDecoder()

    func loginUser(login: String, password: String) async -> APIAuthResponse? {
        guard let request = try? AuthAPI.login(login: login, password: password).asRequest()
        else { return nil }

        let result = await transportLayer.makeRequest(request: request)
        switch result {
        case .failure:
            return nil
        case .success(let data):
            return try? decoder.decode(APIAuthResponse.self, from: data)
        }
    }
    
    func registerUser(login: String, password: String) async -> APIAuthResponse? {
        guard let request = try? AuthAPI.register(login: login, password: password).asRequest()
        else { return nil }

        let result = await transportLayer.makeRequest(request: request)
        switch result {
        case .failure:
            return nil
        case .success(let data):
            return try? decoder.decode(APIAuthResponse.self, from: data)
        }
    }
}
