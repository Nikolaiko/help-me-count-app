//
//  ActionsViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import UIKit

class ActionsViewController: BaseController {

    var router: MainFeatureRouter?

    private let screenTitle: UILabel = .screenTitle(text: "Список действий")
    private let floatingButton: UIButton = .floatingActionButton(title: "+")

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.title = "Actions"

        addSubviews()
        setupViews()
        makeConstraints()
    }

    private func addSubviews() {
        view.addSubview(screenTitle)
        view.addSubview(floatingButton)
    }

    private func setupViews() {
        floatingButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }

    private func makeConstraints() {
        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.centerX.equalTo(view)
        }

        floatingButton.snp.makeConstraints { currentView in
            currentView.width.equalTo(60)
            currentView.height.equalTo(60)
            currentView.trailing.equalTo(view).inset(20)
            currentView.bottom.equalTo(view).inset(20)
        }
    }

    @objc
    private func addAction() {
        guard let navParent = self.navigationController else { return }

        do {
            try router?.navigateToAddAction(parent: navParent)
        } catch {
            showErrorAlert(title: "Error during navigation")
        }
    }
}
