//
//  Labes.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.12.2025.
//

import UIKit

extension UILabel {
    public static func simpleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .Roboto.regular(size: 16.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }

    public static func simpleLabelLocalized(text: String) -> UILabel {
        let label = UILabel()
        label.font = .Roboto.regular(size: 16.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "Login")
        return label
    }

    public static func errorLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .Roboto.bold(size: 14.0)
        label.textColor = .errorTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }

    public static func screenTitle(text: String) -> UILabel {
        let label = UILabel()
        label.font = .Roboto.bold(size: 24.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
}
