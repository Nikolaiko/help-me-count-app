//
//  Button.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 20.12.2025.
//

import UIKit

extension UIButton {

    public static func redButton(title: String) -> UIButton {
        let attributes = [
            NSAttributedString.Key.font: UIFont.Roboto.bold(size: 14.0),
            NSAttributedString.Key.foregroundColor: UIColor.trueBlack,
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

    public static func blueButton(title: String) -> UIButton {
        let attributes = [
            NSAttributedString.Key.font: UIFont.Roboto.bold(size: 14.0),
            NSAttributedString.Key.foregroundColor: UIColor.trueBlack,
        ] as [NSAttributedString.Key : Any]

        let container = AttributeContainer(attributes)
        var configuration = Configuration.filled()

        configuration.cornerStyle = Configuration.CornerStyle.small
        configuration.baseBackgroundColor = .trueBlue
        configuration.attributedTitle = AttributedString(title, attributes: container)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    public static func floatingAction(title: String) -> UIButton {
        let floatingButton = UIButton(type: .custom)
        floatingButton.setTitle(title, for: .normal)
        floatingButton.backgroundColor = UIColor.trueWhite
        floatingButton.setTitleColor(.trueBlack, for: .normal)

        floatingButton.layer.cornerRadius = 30
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        floatingButton.layer.shadowOpacity = 0.5
        floatingButton.layer.shadowRadius = 4
        floatingButton.translatesAutoresizingMaskIntoConstraints = false


        return floatingButton
    }
}
