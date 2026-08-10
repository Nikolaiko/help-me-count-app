//
//  ActionsBoardViewController.swift
//  HelpMeCount
//
//  View знает Interactor (BusinessLogic) и Router (Routing + DataPassing) — оба через протоколы.
//  Обрати внимание на didSelectRow: VC сначала просит Interactor зафиксировать выбор в DataStore,
//  затем просто просит роутер сделать переход. Сам выбранный элемент во View->Router НЕ передаётся.
//

import UIKit

protocol ActionsBoardDisplayLogic: AnyObject {
    func displayActions(viewModel: ActionsBoard.Load.ViewModel)
}

final class ActionsBoardViewController: UIViewController, ActionsBoardDisplayLogic {
    var interactor: ActionsBoardBusinessLogic?
    var router: (ActionsBoardRoutingLogic & ActionsBoardDataPassing)?

    private let table = UITableView()
    private var rows: [ActionsBoard.Load.ViewModel.Row] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Действия"
        view.backgroundColor = .systemBackground

        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        interactor?.loadActions(request: .init())
    }

    func displayActions(viewModel: ActionsBoard.Load.ViewModel) {
        rows = viewModel.rows
        table.reloadData()
    }
}

extension ActionsBoardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = rows[indexPath.row].title
        config.secondaryText = rows[indexPath.row].progress
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.selectAction(request: .init(index: indexPath.row)) // 1) зафиксировать выбор в DataStore
        router?.routeToDetail()                                         // 2) роутер сам возьмёт его из DataStore
    }
}
