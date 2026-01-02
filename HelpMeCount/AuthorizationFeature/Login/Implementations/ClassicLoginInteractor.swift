//
//  ClassicLoginInteractor.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import Foundation

class ClassicLoginInteractor: LoginInteractor {
    private let presenter: LoginPresenter
    private let localStorage: LocalStorageService

    init(presenter: LoginPresenter, localStorage: LocalStorageService) {
        self.presenter = presenter
        self.localStorage = localStorage
    }
}
