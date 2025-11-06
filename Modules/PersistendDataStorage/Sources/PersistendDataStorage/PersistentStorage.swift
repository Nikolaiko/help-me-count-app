//
//  File.swift
//  PersistendDataStorage
//
//  Created by Nikolai Baklanov on 01.11.2025.
//

import Foundation
import CommonModels

protocol PersistentStorage {
    func getLoggedUser() async -> User?

}
