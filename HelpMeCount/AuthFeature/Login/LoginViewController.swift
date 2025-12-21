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

    private var loginLabel: UILabel = .simpleLabel(text: "Email")

    private var labelPassword: UILabel = .simpleLabel(text: "Password")

    private var errorLabel: UILabel = .errorLabel(text: "Error label")

    private var loginTextField: UITextField  = {
        let login = UITextField.inputField()
        login.placeholder = "email"
        login.autocapitalizationType = .none
        return login
    }()

    private var passwordTextField: UITextField  = {
        let password = UITextField.inputField()
        password.placeholder = "password"
        password.autocapitalizationType = .none
        return password
    }()

    private var registerButton: UIButton = .authButton(title: "Register")
    private var loginButton: UIButton = .authButton(title: "Login")

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
            make.top.equalTo(loginTextField.snp.bottom).offset(30)
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
