//
//  AppRootViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 27.12.2025.
//

import Foundation
import UIKit

class AppRootViewController: BaseController {
    var interactor: AppRootInteractor?
    var router: AppRootRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.checkLoginStatus()
    }

    func userLoggedIn() {
        do {
            try router?.navigateToMain(navController: self.navigationController!)
        } catch _ as DIError {
            showAlert(title: "Ошибка DI!", message: "При навигации")
        } catch {
            showAlertUnknownError()
        }
    }

    func userNotLoggedIn() {
        do {
            try router?.navigateToLogin(navController: self.navigationController!)
        } catch _ as DIError {
            showAlert(title: "Ошибка DI!", message: "При навигации")
        } catch {
            showAlertUnknownError()
        }
    }
}
