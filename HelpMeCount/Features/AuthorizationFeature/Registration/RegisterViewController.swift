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

    private let registerButton: UIButton = .coloredButton(title: "Register", background: .authBackgroundColor)
    private let backButton: UIButton = .coloredButton(title: "Back", background: .authBackgroundColor)

    private let errorLabel: UILabel = .errorLabel(text: "Error!")

    private let loadingIndicator = UIActivityIndicatorView()


    var interactor: RegisterInteractor?
    var router: AuthRouter?

    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViews()
        setupConstraints()


    }

    // MARK: Public functions

    func setLoginEnabled(isEnabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.registerButton.isEnabled = isEnabled
        }
    }

    func setIsLoading(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.registerButton.isEnabled = !isLoading
            self.backButton.isEnabled = !isLoading
            self.loginTextField.isEnabled = !isLoading
            self.passwordTextField.isEnabled = !isLoading

            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
    }

    func showErrorText(errorText: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.errorLabel.text = errorText
            self.errorLabel.isHidden = false
        }
    }

    func hideError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.errorLabel.isHidden = true
        }
    }

    func successRegister() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let navParent = self.navigationController else { return }

            router?.routeToAuthorized(parent: navParent)
        }
    }

    // MARK: Private functions

    private func setupViews() {

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
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)

        errorLabel.isHidden = true
        registerButton.isEnabled = false

        loginTextField.addTarget(self, action: #selector(loginDidChange), for: .editingChanged)

        passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
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
        router?.routeBackToLogin(parent: navParent)
    }

    @objc
    private func registerUser() {
        interactor?.registerUser()
    }

    @objc
    func loginDidChange(_ textField: UITextField) {
        interactor?.updateLogin(newValue: textField.text ?? "")
    }

    @objc
    func passwordDidChange(_ textField: UITextField) {
        interactor?.updatePassword(newValue: textField.text ?? "")
    }
}

