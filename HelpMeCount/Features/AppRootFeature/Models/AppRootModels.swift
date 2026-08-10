//
//  AppRootModels.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

enum AppRoot {
    enum CheckLoginStatus {
        struct Request {}

        struct Response {
            let isLogged: Bool
        }

        struct ViewData {
            enum Destination {
                case login
                case authorized
            }

            let destination: Destination
        }
    }
}
