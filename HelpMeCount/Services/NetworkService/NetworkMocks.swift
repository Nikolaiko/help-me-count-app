//
//  NetworkMocks.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 05.01.2026.
//

import Foundation

struct AlwaysLoginMock: NetworkService {
    func loginUser(login: String, password: String) async -> AuthResponse? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return AuthResponse(
            token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHBpcmF0aW9uIjoxNzY3NjIwOTI5LjQwNTE3MzMsInVzZXJJZCI6IkE4RDNEMjMwLUQ5NUEtNDI2OS1CNzVCLUExM0I3QkEzNzBCMSJ9.avoqegR_2NgBJfHV8AUFaJ6Wa-_6WTObhqIxrqSJJLs",
            refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJBOEQzRDIzMC1EOTVBLTQyNjktQjc1Qi1BMTNCN0JBMzcwQjEiLCJleHBpcmF0aW9uIjo0OTIzMjkwOTI5LjQwNTE4NCwic3ViamVjdCI6IkE4RDNEMjMwLUQ5NUEtNDI2OS1CNzVCLUExM0I3QkEzNzBCMSJ9.Lh0zl403_OWQDm0HCZaljgjrFmlTMLX-4LY2u9GSomA"
        )
    }

    func registerUser(login: String, password: String) async -> AuthResponse? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return AuthResponse(
            token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHBpcmF0aW9uIjoxNzY3NjIwOTI5LjQwNTE3MzMsInVzZXJJZCI6IkE4RDNEMjMwLUQ5NUEtNDI2OS1CNzVCLUExM0I3QkEzNzBCMSJ9.avoqegR_2NgBJfHV8AUFaJ6Wa-_6WTObhqIxrqSJJLs",
            refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJBOEQzRDIzMC1EOTVBLTQyNjktQjc1Qi1BMTNCN0JBMzcwQjEiLCJleHBpcmF0aW9uIjo0OTIzMjkwOTI5LjQwNTE4NCwic3ViamVjdCI6IkE4RDNEMjMwLUQ5NUEtNDI2OS1CNzVCLUExM0I3QkEzNzBCMSJ9.Lh0zl403_OWQDm0HCZaljgjrFmlTMLX-4LY2u9GSomA"
        )
    }
}

struct AlwaysFailLoginMock: NetworkService {
    func loginUser(login: String, password: String) async -> AuthResponse? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return nil
    }

    func registerUser(login: String, password: String) async -> AuthResponse? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return nil
    }
}
