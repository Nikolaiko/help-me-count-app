//
//  LoginViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.10.2025.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(loginButton)
    }

    private func addConstraints() {
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y)
        }
    }
}
