//
//  AlwaysLoggedInService.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

struct AlwaysLoggedInService: LocalStorageService {
    func getUserToken() -> String? {
        "HEH"
    }

    func saveUserToken(newToken: String) -> String? {
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJBOEQzRDIzMC1EOTVBLTQyNjktQjc1Qi1BMTNCN0JBMzcwQjEiLCJleHBpcmF0aW9uIjo0OTIzMjkwOTI5LjQwNTE4NCwic3ViamVjdCI6IkE4RDNEMjMwLUQ5NUEtNDI2OS1CNzVCLUExM0I3QkEzNzBCMSJ9.Lh0zl403_OWQDm0HCZaljgjrFmlTMLX-4LY2u9GSomA"
    }
}
