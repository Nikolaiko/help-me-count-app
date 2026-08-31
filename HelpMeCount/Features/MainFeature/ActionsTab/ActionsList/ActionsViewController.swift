//
//  ActionsViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.01.2026.
//

import UIKit

class ActionsViewController: BaseController, ActionsView {

    var interactor: ActionsListInteractor?
    var router: MainFeatureRouter?

    private let screenTitle: UILabel = .screenTitle(text: "Список действий")
    private let floatingButton: UIButton = .floatingActionButton(title: "+")
    private let actionsTable = UITableView()
    private let refreshControl = UIRefreshControl()

    private var actions: [CountableAction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.title = "Actions"

        actionsTable.allowsSelection = false
        actionsTable.separatorStyle = .none
        actionsTable.dataSource = self
        actionsTable.backgroundColor = .trueWhite
        actionsTable.register(ActionTableViewCell.self, forCellReuseIdentifier: ActionTableViewCell.identifier)

        refreshControl.addTarget(self, action: #selector(updateActionsList), for: .valueChanged)

        addSubviews()
        setupViews()
        makeConstraints()
        updateActionsList()
    }

    func refreshActionsList(viewData: RefreshActions.ViewData) {
        Task { @MainActor in
            self.actions = viewData.actions
            actionsTable.reloadData()
        }
    }

    private func addSubviews() {
        actionsTable.addSubview(refreshControl)

        view.addSubview(screenTitle)
        view.addSubview(actionsTable)
        view.addSubview(floatingButton)
    }

    private func setupViews() {
        actionsTable.separatorStyle = .none

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

        actionsTable.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom)
            currentView.leading.equalTo(view)
            currentView.trailing.equalTo(view)
            currentView.bottom.equalTo(view)
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

    @objc
    private func updateActionsList() {
        interactor?.resfreshActionsList()
        refreshControl.endRefreshing()
    }
}

extension ActionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionTableViewCell.identifier,
                                                 for: indexPath) as! ActionTableViewCell
        cell.setAction(action: actions[indexPath.row])
        cell.plusTapCallback = { [weak self] in
            guard let self else { return }
            interactor?.addActionRepetition(request: AddActionRepetition.Request(action: actions[indexPath.row]))
        }
        return cell
    }
}
