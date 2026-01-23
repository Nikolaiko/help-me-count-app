//
//  AddActionViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import UIKit

class AddActionViewController: BaseController {
    private let screenTitle: UILabel = .screenTitle(text: "Actions")

    private var titleLabel: UILabel = .simpleLabel(text: "Email")
    private var maxCountRepeatsLabel: UILabel = .simpleLabel(text: "Password")

    private let actionInputField: AppInputTextField = .init(title: "Название действия")

    private var errorLabel: UILabel = .errorLabel(text: "Error label")

    private var titleTextField: UITextField  = {
        let login = UITextField.inputField()
        login.placeholder = "email"
        login.autocapitalizationType = .none
        return login
    }()

    private var maxRepeatsTextField: UITextField  = {
        let password = UITextField.inputField()
        password.placeholder = "password"
        password.autocapitalizationType = .none
        return password
    }()

    private var registerButton: UIButton = .authButton(title: "Register")
    private var loginButton: UIButton = .authButton(title: "Login")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    private func setupViews() {
        
    }

    private func addSubviews() {
        view.addSubview(screenTitle)

//        view.addSubview(titleLabel)
//        view.addSubview(maxCountRepeatsLabel)
//
//        view.addSubview(titleTextField)
//        view.addSubview(maxRepeatsTextField)

        view.addSubview(actionInputField)

    }

    private func makeConstraints() {

        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.left.equalTo(view)
            currentView.right.equalTo(view)
        }

        actionInputField.snp.makeConstraints { currentView in
            currentView.centerX.equalTo(view)
            currentView.centerY.equalTo(view)
            currentView.left.equalTo(view)
            currentView.right.equalTo(view)            
        }
    }

}
