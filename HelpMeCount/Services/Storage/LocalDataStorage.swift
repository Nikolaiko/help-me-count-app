//
//  LocalDataStorage.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 09.11.2025.
//

import Foundation

protocol LocalDataStorage: AnyObject {

    var delegate: DBUpdateListener? { get set }

    @discardableResult
    func getLoggedUser() async -> TokenData?

    @discardableResult
    func saveLoggedUser(_ token: TokenData) async -> TokenData?
}
