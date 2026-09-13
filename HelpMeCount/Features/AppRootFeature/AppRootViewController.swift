//
//  AppRootViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class AppRootViewController: BaseController, AppRootView {

    var interactor: AppRootInteractor?
    var router: AppRootRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.checkLoginStatus()
    }

    func isUserLogged(viewData: CheckLoginStatus.ViewData) {
        do {
            if viewData.isLogged {
                try router?.navigateToAuthorized()
            } else {
                try router?.navigateToLogin()
            }
        } catch _ as DIErrors {
            showDIError()
        } catch {
            showErrorAlert(title: "Неизвестаня ошибка")
        }
    }

    func getNavController() -> UINavigationController? { self.navigationController }
}
