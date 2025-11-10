//
//  AppNetworkService.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 10.11.2025.
//

import Foundation

struct AppNetworkService: NetworkService {
    private static let baseAddress = "http://e97b67a8bc6.vps.myjino.ru:49235"
    private let httpLayer = URLSessionLayer()

    func registerRequest(login: String, password: String) async -> UserToken? {
        var request = URLRequest(url: URL(string: "\(AppNetworkService.baseAddress)/authorization/register")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(AuthRequest(username: login, password: password))

        let result = await httpLayer.makeRequest(urlRequest: request)
        switch result {
        case .success(let data):
            let token = try? JSONDecoder().decode(UserToken.self, from: data)
            print(token)
            return token
        case .failure(let error):
            print(error)
            return nil
        }
    }

    func loginRequest(login: String, password: String) async -> UserToken? {
        let loginString = String(format: "%@:%@", login, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: URL(string: "\(AppNetworkService.baseAddress)/authorization/login")!)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let result = await httpLayer.makeRequest(urlRequest: request)
        switch result {
        case .success(let data):
            let token = try? JSONDecoder().decode(UserToken.self, from: data)
            return token
        case .failure(let error):
            print(error)
            return nil
        }
    }
}
