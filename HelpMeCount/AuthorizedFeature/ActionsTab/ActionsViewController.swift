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
    private var actions: [CountableAction] = [CountableAction(id: 4, title: "Title", maxRepeates: 4, currentRepeats: 0)]

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.title = "Actions"
        view.backgroundColor = .red

        actionsTable.dataSource = self
        actionsTable.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")

        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        view.addSubview(actionsTable)


    }

    private func makeConstraints() {
        actionsTable.snp.makeConstraints { currentView in
            currentView.top.equalTo(view)
            currentView.left.equalTo(view)
            currentView.bottom.equalTo(view)
            currentView.right.equalTo(view)
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

