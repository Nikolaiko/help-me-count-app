//
//  CheckLoginStatus.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 08.09.2026.
//

import Foundation

enum CheckLoginStatus {
    struct Response {
        let isLogged: Bool
    }

    struct ViewData {
        let isLogged: Bool
    }
}
