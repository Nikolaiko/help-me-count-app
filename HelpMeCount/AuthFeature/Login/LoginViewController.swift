//
//  LoginViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.10.2025.
//

import Foundation
import UIKit
import UIKitNavigation

final class LoginViewController: UIViewController {

    private var loginLabel: UILabel = {
        $0.text = "Login"
        return $0
    }(UILabel())

    private var labelPassword: UILabel = {
        $0.text = "Password"
        return $0
    }(UILabel())

    private var errorLabel: UILabel = {
        $0.text = "Error message"
        $0.textColor = .red
        $0.isHidden = true
        return $0
    }(UILabel())

    private var loginTextField: UITextField  = {
        $0.placeholder = "imail"
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 24
        $0.autocapitalizationType = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    private var passwordTextField: UITextField  = {
        $0.placeholder = "password"
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 24
        $0.autocapitalizationType = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    private var registerButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Register"

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Login"

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var interactor: LoginInteractor?
    var router: AuthRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func onLoginResult(success: Bool) {
        if success {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
        }
    }

    func setLoginButtonEnabled(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }

    func setIsLoading(isLoading: Bool) {
        loginButton.isEnabled = !isLoading
    }
}

private extension LoginViewController {

    func setupViews() {
        view.backgroundColor = .white

        view.addSubview(loginLabel)
        view.addSubview(labelPassword)
        view.addSubview(errorLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginButton)

        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginCallback)))

        registerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerCallback)))

        loginTextField.delegate = self
        passwordTextField.delegate = self

        errorLabel.isHidden = true
    }

    func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view).inset(224)
            make.left.equalTo(view).inset(60)

        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(12)
            make.left.equalTo(view).inset(52)
            make.right.equalTo(view).inset(48)
            make.height.equalTo(62)
        }

        labelPassword.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(7)
            make.left.equalTo(view).inset(62)

        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(labelPassword.snp.bottom).offset(12)
            make.left.equalTo(view).inset(52)
            make.right.equalTo(view).inset(48)
            make.height.equalTo(62)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(56)
            make.left.right.equalTo(view).inset(68)
            make.height.equalTo(54)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(68)
            make.height.equalTo(54)
        }

        errorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(112)
            make.centerX.equalTo(view)
        }
    }

    @objc
    func loginCallback() {
        interactor?.login()
    }

    @objc
    func registerCallback() {
        try? router?.navigateToRegister(source: self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let range = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: string)

        if textField == loginTextField {
            interactor?.updateLogin(newLogin: updatedText)
        }
        if textField == passwordTextField {
            interactor?.updatePassword(newPassword: updatedText)
        }

        return true
    }
}
