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

    private let actionsTable = UITableView()
    private let floatingButton: UIButton = .floatingAction(title: "+")

    private var actions: [CountableAction] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        actionsTable.dataSource = self
        actionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")

        addSubviews()
        makeConstraints()

        tabBarItem.title = "Actions"

        interactor?.getAllActions()
    }

    func updateActionsList(actions: [UserRepeatableAction]) {
        
    }

    private func addSubviews() {
        view.addSubview(actionsTable)
        view.insertSubview(floatingButton, aboveSubview: actionsTable)
    }

    private func makeConstraints() {
        actionsTable.snp.makeConstraints { currentView in
            currentView.top.equalTo(view)
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

