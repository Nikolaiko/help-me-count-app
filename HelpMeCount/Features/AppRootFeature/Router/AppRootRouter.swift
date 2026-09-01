//
//  File.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

protocol AppRootRoutingLogic {
    func routeToLogin()
    func routeToAuthorized()
}

protocol AppRootDataPassing {
    var dataStore: AppRootDataStore? { get }
}

protocol AppRootDataStore {
    // Пока сцены не делятся данными напрямую — слот на будущее.
}
