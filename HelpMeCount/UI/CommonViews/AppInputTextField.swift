//
//  AppInputTextField.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 23.01.2026.
//

import UIKit
import SnapKit

class AppInputTextField: UIView {

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

    public func setTitle(title: String) {
        titleLabel.text = title
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(inputTextField)
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
}
