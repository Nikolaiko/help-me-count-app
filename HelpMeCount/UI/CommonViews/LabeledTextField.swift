//
//  LabeledTextField.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 26.01.2026.
//

import UIKit

class LabeledTextField: UIView {

    var callback: LabeledTextFieldChangeCallback?

    private let titleLabel: UILabel = .simpleLabel(text: "")
    private var textField: UITextField = {
        let textField = UITextField.inputField()
        textField.autocapitalizationType = .none
        return textField
    }()

    convenience init(title: String = "",
                     placeholder: String = "",
                     keyboardType: UIKeyboardType = .default) {
        self.init(frame: CGRect.zero)

        titleLabel.text = title
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupViews()
        makeConstraints()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 260, height: 90)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupViews()
        makeConstraints()
    }

    func getCurrentText() -> String {
        textField.text ?? ""
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(textField)

        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { currentView in
            currentView.top.equalTo(self)
            currentView.left.equalTo(self)
        }

        textField.snp.makeConstraints { currentView in
            currentView.left.equalTo(self)
            currentView.right.equalTo(self)
            currentView.top.equalTo(titleLabel.snp.bottom).offset(12)
            currentView.height.equalTo(62)
        }
    }

    @objc
    func textDidChange(_ textField: UITextField) {
        callback?(textField.text ?? "")
    }
}
