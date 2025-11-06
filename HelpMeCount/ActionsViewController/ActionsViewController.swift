//
//  ViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 22.10.2025.
//

import UIKit
import SnapKit

class ActionsViewController: UIViewController {

    private let actionsTable = UITableView()
    private var actions: [CountableAction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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

