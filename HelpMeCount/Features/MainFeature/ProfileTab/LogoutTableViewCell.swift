//
//  ActionTableViewCell.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 07.06.2026.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {
    public static let identifier: String = "LogoutTableViewCell"

    private let logoutButton: UIButton = .coloredButton(title: "Выйти", background: .trueBlue)
    private let subView = UIView()

    public var logoutCallback: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(subView)
        subView.addSubview(logoutButton)

        setupViews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .trueWhite

        logoutButton.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
    }

    private func makeConstraints() {
        logoutButton.snp.makeConstraints { button in
            button.top.equalTo(subView).offset(10)
            button.bottom.equalTo(subView).offset(-10)
            button.right.equalTo(subView)
        }

        subView.snp.makeConstraints { currentView in
            currentView.top.equalTo(contentView)
            currentView.bottom.equalTo(contentView)
            currentView.left.equalTo(contentView)
            currentView.right.equalTo(contentView)
        }
    }

    @objc
    private func logoutButtonTap() {
        logoutCallback?()
    }
}
