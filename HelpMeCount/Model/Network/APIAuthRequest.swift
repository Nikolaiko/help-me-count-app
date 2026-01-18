//
//  APIAuthRequest.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.01.2026.
//

import Foundation

struct APIAuthRequest: Encodable {
    let username: String
    let password: String
}
