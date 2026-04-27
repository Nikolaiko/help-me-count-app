//
//  AddActionViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

class AddActionViewController: BaseController {
    var interactor: AddActionInteractor?
    var router: MainFeatureRouter?

    private let screenTitle: UILabel = .screenTitle(text: "Список действий")

    private let actionTitleField = LabeledTextField(title: "Название действия", placeholder: "Название действия")

    private let maxRepeatsField = LabeledTextField(title: "Максимум повторений", placeholder: "Максимум повторений", keyboardType: .numberPad)


    private let currentRepeatsField = LabeledTextField(title: "Повторения", placeholder: "Повторения", keyboardType: .numberPad)

    private let addButton: UIButton = .coloredButton(title: "Создать", background: .trueBlue)
    private let cancelButton: UIButton = .coloredButton(title: "Отмена", background: .authBackgroundColor)

    private let inputFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 30
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 30
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupViews()
        makeConstraints()

        updateName(name: actionTitleField.getCurrentText())
        updateMaxCount(count: maxRepeatsField.getCurrentText())
        updateCurrentCount(count: currentRepeatsField.getCurrentText())

        actionTitleField.callback = updateName
        maxRepeatsField.callback = updateMaxCount
        currentRepeatsField.callback = updateCurrentCount

        addButton.addTarget(self, action: #selector(addNewAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(backToActionsList), for: .touchUpInside)
    }

    func setAddButtonEnabled(enabled: Bool) {
        Task { @MainActor in
            addButton.isEnabled = enabled
        }
    }

    func newActionAdded() {
        backToActionsList()
    }

    private func addSubviews() {
        inputFieldsStack.addArrangedSubview(actionTitleField)
        inputFieldsStack.addArrangedSubview(maxRepeatsField)
        inputFieldsStack.addArrangedSubview(currentRepeatsField)

        buttonsStack.addArrangedSubview(cancelButton)
        buttonsStack.addArrangedSubview(addButton)

        view.addSubview(screenTitle)
        view.addSubview(inputFieldsStack)
        view.addSubview(buttonsStack)
    }

    private func setupViews() {
        view.backgroundColor = .trueWhite
    }

    private func makeConstraints() {
        screenTitle.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            currentView.centerX.equalTo(view)
        }

        inputFieldsStack.snp.makeConstraints { currentView in
            currentView.top.equalTo(screenTitle.snp.bottom).offset(20)
            currentView.left.equalTo(view).offset(70)
            currentView.right.equalTo(view).offset(-70)
        }

        buttonsStack.snp.makeConstraints { currentView in
            currentView.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            currentView.left.equalTo(view).offset(12)
            currentView.right.equalTo(view).offset(-12)
            currentView.height.equalTo(54)
        }
    }

    private func updateName(name: String) {
        interactor?.updateActionName(name: name)
    }

    private func updateMaxCount(count: String) {
        let convertedInt = Int(count)
        interactor?.updateMaxCount(count: convertedInt)
    }

    private func updateCurrentCount(count: String) {
        let convertedInt = Int(count)
        interactor?.updateCurrentCount(count: convertedInt)
    }

    @objc
    private func backToActionsList() {
        Task { @MainActor in
            guard let navParent = self.navigationController else { return }
            router?.backFromAddAction(parent: navParent)
        }
    }

    @objc
    private func addNewAction() {
        interactor?.createNewAction()
    }
}

