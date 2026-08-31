//
//  RefreshActions.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.08.2026.
//

import Foundation

enum RefreshActions {
    struct Response {
        let actions: [CountableAction]
    }
    
    struct ViewData {
        let actions: [CountableAction]
    }
}
