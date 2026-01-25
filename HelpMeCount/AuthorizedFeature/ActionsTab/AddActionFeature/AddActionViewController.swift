//
//  AddActionViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 04.01.2026.
//

import UIKit

class AddActionViewController: BaseController {

    var interactor: AddActionInteractor?
    var router: AppAuthorizedRouter?

    private let screenTitle: UILabel = .screenTitle(text: "Actions")

    private let inputElementsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 150
        stack.isUserInteractionEnabled = true
        return stack
    }()

    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 30
        stack.isUserInteractionEnabled = true
        return stack
    }()

    private var loginTextField: UITextField  = {
        let login = UITextField.inputField()
        login.placeholder = "email"
        login.autocapitalizationType = .none
        return login
    }()

    private let actionInputField: LabeledTextField = .init(title: "Название действия")
    private let maxCountsInputField: LabeledTextField = .init(title: "Максимум повторений")
    private let currentCountsInputField: LabeledTextField = .init(title: "Текущее количество повторений")

    private var errorLabel: UILabel = .errorLabel(text: "Error label\nError label\nError label", lines: 3)

    private var acceptButton: UIButton = .blueButton(title: "Создать")
    private var cancelButton: UIButton = .redButton(title: "Отмена")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    func setAddActionEnabled(_ isEnabled: Bool) {
        acceptButton.isEnabled = isEnabled
    }

    private func setupViews() {

        actionInputField.setTitle(title: "dfddfkjfddfkjjkdfjkdfjkdfjkdfkjdfjk")

        actionInputField.textCallback = actionNametextField
        maxCountsInputField.textCallback = maxCountstextField
        currentCountsInputField.textCallback = currentCountstextField

        currentCountsInputField.isUserInteractionEnabled = true
        //maxCountsInputField.setKeyboardType(type: .numberPad)
        //currentCountsInputField.setKeyboardType(type: .numberPad)

        acceptButton.isEnabled = false

        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(screenTitle)

        inputElementsStack.addArrangedSubview(actionInputField)
        inputElementsStack.addArrangedSubview(maxCountsInputField)
        //inputElementsStack.addArrangedSubview(currentCountsInputField)

        buttonsStack.addArrangedSubview(cancelButton)
        buttonsStack.addArrangedSubview(acceptButton)

//        view.addSubview(titleLabel)
//        view.addSubview(maxCountRepeatsLabel)
//
//        view.addSubview(titleTextField)
//        view.addSubview(maxRepeatsTextField)

        view.addSubview(buttonsStack)
        view.addSubview(inputElementsStack)
        view.addSubview(errorLabel)
        view.addSubview(currentCountsInputField)
        view.addSubview(loginTextField)
    }

    private func makeConstraints() {



        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.left.equalTo(view)
            currentView.right.equalTo(view)
        }

        inputElementsStack.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom).offset(30)
            //currentView.bottom.equalTo(view)
            currentView.left.equalTo(view).offset(70)
            currentView.right.equalTo(view).offset(-70)
        }

        buttonsStack.snp.makeConstraints { currentView in
            currentView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            currentView.centerX.equalTo(view)
            currentView.left.equalTo(view).offset(12)
            currentView.right.equalTo(view).offset(-12)
            currentView.height.equalTo(54)
        }

        errorLabel.snp.makeConstraints { currentView in
            currentView.top.equalTo(inputElementsStack.snp.bottom).offset(120)
            currentView.centerX.equalTo(view)
        }

        loginTextField.snp.makeConstraints { currentView in
            currentView.top.equalTo(errorLabel.snp.bottom)
            currentView.centerX.equalTo(view)
            currentView.left.equalTo(view).offset(70)
            currentView.right.equalTo(view).offset(-70)
        }

        currentCountsInputField.snp.makeConstraints { currentView in
            currentView.top.equalTo(loginTextField.snp.bottom)
            currentView.centerX.equalTo(view)
            currentView.left.equalTo(view).offset(70)
            currentView.right.equalTo(view).offset(-70)
        }
    }

    private func actionNametextField(_ value: String) {
        interactor?.updateActionName(value)
    }

    private func maxCountstextField(_ value: String) {
        guard let convertedInt = Int(value) else { return }
        interactor?.updateMaxCounts(convertedInt)
    }

    private func currentCountstextField(_ value: String) {
        guard let convertedInt = Int(value) else { return }
        interactor?.updateCurrentCount(convertedInt)
    }

    @objc
    private func cancelTapped() {
        router?.returnFromAddAction()
    }
}
