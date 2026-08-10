//
//  RootPresenter.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import Foundation

class RootPresenter: AppRootPresenter {
    private weak var view: AppRootDisplayLogic?

    init(view: AppRootDisplayLogic) {
        self.view = view
    }

    func presentLoginStatus(response: AppRoot.CheckLoginStatus.Response) {
        let destination: AppRoot.CheckLoginStatus.ViewData.Destination =
            response.isLogged ? .authorized : .login

        view?.displayLoginStatus(
            viewData: AppRoot.CheckLoginStatus.ViewData(destination: destination)
        )
    }
}
