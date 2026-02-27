//
//  NetworkService.swift
//  TrainingSessions
//
//  Created by Yakov on 23.10.2025.
//

import Foundation

protocol NetworkService {
    func registerRequest(login: String, password: String) async -> Result<TokenData, NetworkErrors>
    func loginRequest(login: String, password: String) async -> Result<TokenData, NetworkErrors>
    func getAllActions() async -> Result<[CountableAction], NetworkErrors>
    func addAction(newAction: NewCountableAction) async -> Result<CountableAction, NetworkErrors>
}
