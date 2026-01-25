//
//  Labels.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 20.12.2025.
//

import UIKit

extension UILabel {
    public static func buttonLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.Roboto.bold(size: 14.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    public static func simpleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.Roboto.regular(size: 16.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        
        return label
    }

    public static func errorLabel(text: String = "", lines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = UIFont.Roboto.bold(size: 14.0)
        label.textColor = .errorTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = lines

        return label
    }

    public static func screenTitle(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.Roboto.bold(size: 24.0)
        label.textColor = .trueBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center

        return label
    }
}
