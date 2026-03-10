//
//  NetworkService.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 05.01.2026.
//

import Foundation

protocol NetworkService {
    func loginUser(login: String, password: String) async -> Result<UserToken, NetworkError>
    func registerUser(login: String, password: String) async -> Result<UserToken, NetworkError>
    //func addNewAction() async -> 
}
