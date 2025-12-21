//
//  RegisterViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 18.12.2025.
//

import Foundation
import UIKit
import UIKitNavigation

final class RegisterViewController: UIViewController {

    private var loginLabel: UILabel = .simpleLabel(text: "Email")

    private var passwordLabel: UILabel = .simpleLabel(text: "Password")

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
    private var backButton: UIButton = .authButton(title: "Back")

    var interactor: RegisterInteractor?
    var router: AuthRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func onRegisterResult(success: Bool) {
        if success {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
        }
    }

    func setLoginButtonEnabled(isEnabled: Bool) {
        registerButton.isEnabled = isEnabled
    }

    func setIsLoading(isLoading: Bool) {
        registerButton.isEnabled = !isLoading
    }
}

private extension RegisterViewController {

    func setupViews() {
        view.backgroundColor = .white

        view.addSubview(loginLabel)
        view.addSubview(passwordLabel)
        view.addSubview(errorLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(backButton)

        registerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerCallback)))

        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backCallback)))

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

        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(7)
            make.left.equalTo(view).inset(62)

        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.left.equalTo(view).inset(52)
            make.right.equalTo(view).inset(48)
            make.height.equalTo(62)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(68)
            make.height.equalTo(54)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(56)
            make.left.right.equalTo(view).inset(68)
            make.height.equalTo(54)
        }

        errorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(112)
            make.centerX.equalTo(view)
        }
    }

    @objc
    func registerCallback() {
        interactor?.register()
    }

    @objc
    func backCallback() {
        router?.backToLogin(from: self)
    }
}

extension RegisterViewController: UITextFieldDelegate {
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

