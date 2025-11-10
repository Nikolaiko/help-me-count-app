//
//  LocalDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation

protocol LocalDataStorage {
    func getLoggedUser() -> DBToken?
    func saveLoggedUser(_ token: DBToken) -> DBToken?
}
