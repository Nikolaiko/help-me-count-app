//
//  ViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 22.10.2025.
//

import UIKit
import SnapKit

class ActionsViewController: BaseController {

    var interactor: ActionsInteractor?
    var router: AppAuthorizedRouter?

    private let actionsTable = UITableView()
    private var refreshControl = UIRefreshControl()

    private let floatingButton: UIButton = .floatingAction(title: "+")
    private let screenTitle: UILabel = .screenTitle(text: "Actions")

    private var actions: [CountableAction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(onPullRefresh), for: .valueChanged)

        actionsTable.dataSource = self
        actionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        actionsTable.addSubview(refreshControl)

        addSubviews()
        setupViews()
        makeConstraints()

        tabBarItem.title = "Actions"

        interactor?.getAllActions()
    }

    func updateActionsList(actions: [CountableAction]) {
        DispatchQueue.main.async { [weak self] in
            if self?.refreshControl.isRefreshing ?? false {
                self?.refreshControl.endRefreshing()
            }
            self?.actions = actions
            self?.actionsTable.reloadData()
        }
    }

    private func setupViews() {

        floatingButton.addTarget(self, action: #selector(addNewAction), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(actionsTable)
        view.addSubview(screenTitle)
        view.insertSubview(floatingButton, aboveSubview: screenTitle)
    }

    private func makeConstraints() {

        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.left.equalTo(view)
            currentView.right.equalTo(view)
        }

        actionsTable.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom)
            currentView.left.equalTo(view)
            currentView.bottom.equalTo(view)
            currentView.right.equalTo(view)
        }

        floatingButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        floatingButton.snp.makeConstraints { maker in
            maker.trailing.equalTo(view).inset(20)
            maker.bottom.equalTo(view).inset(20)
        }
    }

    @objc
    private func addNewAction() {
        do {
            try router?.goToAddAction()
        } catch {
            showAlert(title: "DI Error")
        }
    }

    @objc
    private func onPullRefresh() {
        interactor?.getAllActions()
    }
}

extension ActionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].title
        return cell
    }

}

