//
//  ProfileViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 02.06.2026.
//

import UIKit

final class ProfileViewController: BaseController {

    var interactor: ProfileInteractor?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?

    private let screenTitle: UILabel = .screenTitle(text: "Профиль")
    private let actionsTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.title = "Profile"

        actionsTable.allowsSelection = false
        actionsTable.separatorStyle = .none
        actionsTable.dataSource = self
        actionsTable.backgroundColor = .trueWhite
        actionsTable.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.identifier)

        addSubviews()
        setupViews()
        makeConstraints()
    }

    private func addSubviews() {
        view.addSubview(screenTitle)
        view.addSubview(actionsTable)
    }

    private func setupViews() {
    }

    private func makeConstraints() {
        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.centerX.equalTo(view)
        }

        actionsTable.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom)
            currentView.leading.equalTo(view)
            currentView.trailing.equalTo(view)
            currentView.bottom.equalTo(view)
        }
    }

    func showLogoutConfirmation() {
        guard !(presentedViewController is UIAlertController) else { return }

        let alert = UIAlertController(title: "Выйти?",
                                      message: "Хотите выйти?",
                                      preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Остаться", style: .cancel) { _ in }
        let confirmAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.interactor?.clearAllData()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        present(alert, animated: true)
    }

    func returnToLoginScreen() {
        router?.routeToLogin()
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogoutTableViewCell.identifier,
                                                 for: indexPath) as! LogoutTableViewCell
        cell.logoutCallback = { [weak self] in
            guard let self else { return }
            self.interactor?.logout()
        }
        return cell
    }
}
