//
//  Buttons.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.12.2025.
//

import UIKit

extension UIButton {
    public static  func authButton(title: String) -> UIButton {
        let attributes = [
            NSAttributedString.Key.font : UIFont.Roboto.bold(size: 14.0),
            NSAttributedString.Key.foregroundColor : UIColor.trueBlack,
        ] as [NSAttributedString.Key : Any]

        let container = AttributeContainer(attributes)
        var configuration = Configuration.filled()

        configuration.cornerStyle = Configuration.CornerStyle.small
        configuration.baseBackgroundColor = .authBackgroundColor
        configuration.attributedTitle = AttributedString(title, attributes: container)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}
