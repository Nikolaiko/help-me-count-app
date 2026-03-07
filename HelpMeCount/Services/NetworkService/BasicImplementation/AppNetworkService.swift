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

    func registerRequest(login: String, password: String) async -> Result<TokenData, NetworkErrors> {
        var request = URLRequest(url: URL(string: "\(AppNetworkService.baseAddress)/authorization/register")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(APIAuthRequest(username: login, password: password))

        let result = await httpLayer.makeRequest(urlRequest: request)
        switch result {
        case .success(let data):
            let token = try! JSONDecoder().decode(TokenData.self, from: data)
            return .success(token)
        case .failure(let error):
            print(error)
            return .failure(.networkError)
        }
    }

    func loginRequest(login: String, password: String) async -> Result<TokenData, NetworkErrors> {
        let loginString = String(format: "%@:%@", login, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: URL(string: "\(AppNetworkService.baseAddress)/authorization/login")!)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let result = await httpLayer.makeRequest(urlRequest: request)
        switch result {
        case .success(let data):
            let token = try! JSONDecoder().decode(TokenData.self, from: data)
            return .success(token)
        case .failure(let error):
            print(error)
            return .failure(.networkError)
        }
    }

    func getAllActions() async -> Result<[CountableAction], NetworkErrors> {
        let bearer = "Bearer "
        var request = URLRequest(url: URL(string: "\(AppNetworkService.baseAddress)/actions")!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")

        let result = await httpLayer.makeRequest(urlRequest: request)
        switch result {
        case .success(let data):
            if let actions = try? JSONDecoder().decode([CountableAction].self, from: data) {
                return .success(actions)
            } else { return .failure(.decodingError) }
        case .failure(let error):
            return .failure(.networkError)
        }
    }

    func addAction(newAction: NewCountableAction) async -> Result<CountableAction, NetworkErrors> {
        return .failure(.emptyData)
    }
}
