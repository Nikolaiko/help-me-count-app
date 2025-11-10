//
//  NetworkService.swift
//  TrainingSessions
//
//  Created by Yakov on 23.10.2025.
//

import Foundation

protocol NetworkService {
    func registerRequest(login: String, password: String) async -> UserToken?
    func loginRequest(login: String, password: String) async -> UserToken?
}
