//
//  AppInputTextField.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.01.2026.
//

import UIKit
import SnapKit

class LabeledTextField: UIView {
    public var textCallback: TextFieldCallback? = nil

    private let titleLabel: UILabel = .simpleLabel(text: "Default")
    private var inputTextField: UITextField  = {
        let login = UITextField.inputField()
        login.placeholder = "placeholder"
        login.autocapitalizationType = .none
        return login
    }()

    convenience init(title: String = "", placeholder: String = "") {
        self.init(frame: .zero)

        titleLabel.text = title
        inputTextField.placeholder = placeholder
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupView()
        createConstrainsts()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupView()
        createConstrainsts()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        inputTextField.layoutSubviews()
        titleLabel.layoutSubviews()
    }

    public func setTitle(title: String) {
        titleLabel.text = title
        inputTextField.text = title
    }

    public func setKeyboardType(type: UIKeyboardType) {
        inputTextField.keyboardType = type
    }

    private func commonInit() {
        inputTextField.backgroundColor = .red
        inputTextField.isUserInteractionEnabled = true

        inputTextField.addTarget(self, action: #selector(ttt), for: .touchDown)

        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func ttt() {
        print("Touch!")
    }

    private func setupView() {
        //inputTextField.delegate = self

        addSubview(titleLabel)
        addSubview(inputTextField)

        bringSubviewToFront(inputTextField)
    }

    private func createConstrainsts() {
        titleLabel.snp.makeConstraints { currentView in
            currentView.left.equalTo(self)
            currentView.top.equalTo(self)
        }

        inputTextField.snp.makeConstraints { currentView in
            currentView.left.equalTo(self)
            currentView.right.equalTo(self)
            currentView.top.equalTo(titleLabel.snp.bottom).offset(12)
            currentView.height.equalTo(62)
        }
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let range = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: string)

        print("sddsdssd")

        textCallback?(updatedText)
        return true
    }
}
