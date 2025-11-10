//
//  AuthRequest.swift
//  TrainingSessions
//
//  Created by Nikolai Baklanov on 24.10.2025.
//


struct AuthRequest: Codable {
    let username: String
    let password: String
}

struct AuthResponse: Codable {
    let token: String
}
