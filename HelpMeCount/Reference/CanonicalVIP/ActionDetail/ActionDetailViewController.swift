//
//  ActionDetailViewController.swift
//  HelpMeCount
//

import UIKit

protocol ActionDetailDisplayLogic: AnyObject {
    func display(viewModel: ActionDetail.Load.ViewModel)
}

final class ActionDetailViewController: UIViewController, ActionDetailDisplayLogic {
    var interactor: ActionDetailBusinessLogic?
    var router: (ActionDetailRoutingLogic & ActionDetailDataPassing)?

    private let titleLabel = UILabel()
    private let progressLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Детали"
        view.backgroundColor = .systemBackground

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        progressLabel.font = .systemFont(ofSize: 17)
        progressLabel.textColor = .secondaryLabel
        progressLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [titleLabel, progressLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])

        interactor?.load(request: .init())
    }

    func display(viewModel: ActionDetail.Load.ViewModel) {
        titleLabel.text = viewModel.title
        progressLabel.text = viewModel.progress
    }
}
