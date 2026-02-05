//
//  NetworkService.swift
//  TrainingSessions
//
//  Created by Yakov on 23.10.2025.
//

import Foundation

protocol NetworkService {
    func registerRequest(login: String, password: String) async -> TokenData?
    func loginRequest(login: String, password: String) async -> TokenData?
    func getAllActions() async -> [CountableAction]
    func addAction(newAction: NewCountableAction) async -> CountableAction?
}
