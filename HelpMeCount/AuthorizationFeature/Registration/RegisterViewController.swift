//
//  RegisterViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit
import Foundation
import SnapKit

class RegisterViewController: NavChildController {

    // MARK: UIComponents

    private let loginLabel: UILabel = .simpleLabel(text: "Login")

    private var loginTextField: UITextField = {
        let textField: UITextField = .inputField()
        textField.placeholder = "Enter your login"
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordLabel: UILabel = .simpleLabel(text: "Password")

    private var passwordTextField: UITextField = {
        let textField: UITextField = .inputField()
        textField.placeholder = "Enter your password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()

    private let registerButton: UIButton = .authButton(title: "Register")
    private let backButton: UIButton = .authButton(title: "Back")

    private let errorLabel: UILabel = .errorLabel(text: "Error!")

    private let loadingIndicator = UIActivityIndicatorView()

    var router: AuthRouter?

    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViews()
        setupConstraints()


    }


    // MARK: Private functions

    private func setupViews() {

        loadingIndicator.hidesWhenStopped = false
        loadingIndicator.color = .trueBlack
        loadingIndicator.style = .large

        view.addSubview(loginLabel)
        view.addSubview(loginTextField)

        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)

        view.addSubview(registerButton)
        view.addSubview(backButton)

        view.addSubview(errorLabel)
        view.addSubview(loadingIndicator)

        backButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
    }

    private func setupConstraints() {
        loginLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view).inset(224)
            maker.left.equalTo(view).inset(60)
        }

        loginTextField.snp.makeConstraints { maker in
            maker.top.equalTo(loginLabel.snp.bottom).offset(12.0)
            maker.left.equalTo(view).inset(60)
            maker.right.equalTo(view).inset(60)
            maker.height.equalTo(68)
        }

        passwordLabel.snp.makeConstraints { maker in
            maker.top.equalTo(loginTextField.snp.bottom).offset(30)
            maker.left.equalTo(view).inset(60)
        }

        passwordTextField.snp.makeConstraints { maker in
            maker.top.equalTo(passwordLabel.snp.bottom).offset(12.0)
            maker.left.equalTo(view).inset(60)
            maker.right.equalTo(view).inset(60)
            maker.height.equalTo(68)
        }

        registerButton.snp.makeConstraints { maker in
            maker.top.equalTo(passwordTextField.snp.bottom).offset(56.0)
            maker.left.right.equalTo(view).inset(68)
            maker.height.equalTo(54)
        }

        backButton.snp.makeConstraints { maker in
            maker.top.equalTo(registerButton.snp.bottom).offset(20.0)
            maker.left.right.equalTo(view).inset(68)
            maker.height.equalTo(54)
        }

        errorLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.snp.bottom).inset(112)
            maker.centerX.equalTo(view)
        }

        loadingIndicator.snp.makeConstraints { maker in
            maker.centerY.equalTo(view)
            maker.centerX.equalTo(view)
        }
    }

    @objc
    private func backToLogin() {
        guard let navParent = self.navigationController else { return }        
        router?.backToLogin(parent: navParent)
    }
}

