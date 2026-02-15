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
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 30
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

    private let actionInputField: LabeledTextField = .init(title: "Название действия")
    private let maxCountsInputField: LabeledTextField = .init(title: "Максимум повторений")
    private let currentCountsInputField: LabeledTextField = .init(title: "Текущее количество повторений")

    private var errorLabel: UILabel = .errorLabel(text: "", lines: 3)
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

        actionInputField.textCallback = actionNametextField
        maxCountsInputField.textCallback = maxCountstextField
        currentCountsInputField.textCallback = currentCountstextField

        maxCountsInputField.setKeyboardType(type: .numberPad)
        currentCountsInputField.setKeyboardType(type: .numberPad)

        acceptButton.isEnabled = false
        errorLabel.isHidden = true

        acceptButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }

    private func addSubviews() {

        inputElementsStack.addArrangedSubview(actionInputField)
        inputElementsStack.addArrangedSubview(maxCountsInputField)
        inputElementsStack.addArrangedSubview(currentCountsInputField)

        buttonsStack.addArrangedSubview(cancelButton)
        buttonsStack.addArrangedSubview(acceptButton)

        view.addSubview(screenTitle)
        view.addSubview(buttonsStack)
        view.addSubview(inputElementsStack)
        view.addSubview(errorLabel)
    }

    private func makeConstraints() {

        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.left.equalTo(view)
            currentView.right.equalTo(view)
        }

        inputElementsStack.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom).offset(10)
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
            currentView.top.equalTo(buttonsStack.snp.top).offset(-120)
            currentView.centerX.equalTo(view)
        }
    }

    private func actionNametextField(_ value: String) {
        interactor?.updateActionName(value)
    }

    private func maxCountstextField(_ value: String) {
        let convertedInt = Int(value)
        interactor?.updateMaxCounts(convertedInt)
    }

    private func currentCountstextField(_ value: String) {
        let convertedInt = Int(value)
        interactor?.updateCurrentCount(convertedInt)
    }

    @objc
    private func addTapped() {
        interactor?.addAction()
    }

    @objc
    private func cancelTapped() {
        router?.returnFromAddAction()
    }

    func addedAction() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.returnFromAddAction()
        }
    }
}
