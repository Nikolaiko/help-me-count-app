//
//  LocalDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation

protocol LocalDataStorage {
    func getLoggedUser() -> DBUserToken?
    func saveLoggedUser(_ token: DBUserToken) -> DBUserToken?
}
