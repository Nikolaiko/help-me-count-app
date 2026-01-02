//
//  Textfields.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.12.2025.
//

import UIKit

extension UITextField {
    private static let textPadding: UIEdgeInsets = .init(top: 1.0, left: 2.0, bottom: 1.0, right: 2.0)

    public static func inputField() -> UITextField {
        let textField = AppTextField(textPadding: textPadding)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.trueBlack.cgColor
        textField.layer.cornerRadius = 6
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }
}
