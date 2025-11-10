//
//  LoginPresenter.swift
//  TrainingSessions
//
//  Created by Yakov on 23.10.2025.
//

import Foundation

class LoginPresenter {
    private let view: LoginViewController

    init(view: LoginViewController) {
        self.view = view
    }

    func loginResult(result: Bool) {
        view.onLoginResult(success: result)
    }
}
