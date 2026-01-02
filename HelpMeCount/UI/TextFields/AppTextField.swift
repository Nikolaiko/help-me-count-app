//
//  AppTextField.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.12.2025.
//

import UIKit

class AppTextField: UITextField {
    private var textPadding: UIEdgeInsets = .zero

    convenience init(textPadding: UIEdgeInsets) {
        self.init(frame: .zero)
        self.textPadding = textPadding
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
