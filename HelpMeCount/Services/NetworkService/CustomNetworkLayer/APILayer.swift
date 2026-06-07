//
//  APILayer.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct APILayer: NetworkService {
    func increaseActionCount(action: CountableAction) async -> Result<CountableAction, NetworkError> {
        .failure(.client)
    }
    
    func addNewAction(action: NewCountableAction) async -> Result<CountableAction, NetworkError> {
        .failure(.genericNetworkError)
    }

    private let transportLayer = TransportLayer()
    private let decoder = JSONDecoder()

    func loginUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        guard let request = try? AuthAPI.login(login: login, password: password).asRequest()
        else { return .failure(.genericNetworkError) }

        let result = await transportLayer.makeRequest(request: request)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let token = try? decoder.decode(APIAuthResponse.self, from: data).toUserToken()
            else { return .failure(.server) }
            return .success(token)
        }
    }

    func registerUser(login: String, password: String) async -> Result<UserToken, NetworkError> {
        guard let request = try? AuthAPI.register(login: login, password: password).asRequest()
        else { return .failure(.genericNetworkError) }

        let result = await transportLayer.makeRequest(request: request)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            guard let token = try? decoder.decode(APIAuthResponse.self, from: data).toUserToken()
            else { return .failure(.server) }
            return .success(token)
        }
    }

    func getActions() async -> Result<[CountableAction], NetworkError> {
        .success([])
    }
}
