//
//  Buttons.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.12.2025.
//

import UIKit

extension UIButton {
    public static  func coloredButton(title: String, background: UIColor) -> UIButton {
        let attributes = [
            NSAttributedString.Key.font : UIFont.Roboto.bold(size: 14.0),
            NSAttributedString.Key.foregroundColor : UIColor.trueBlack,
        ] as [NSAttributedString.Key : Any]

        let container = AttributeContainer(attributes)
        var configuration = Configuration.filled()

        configuration.cornerStyle = Configuration.CornerStyle.small
        configuration.baseBackgroundColor = background
        configuration.attributedTitle = AttributedString(title, attributes: container)

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    public static func floatingActionButton(title: String) -> UIButton {
        let floatingButton = UIButton(type: .custom)
        floatingButton.setTitle(title, for: .normal)
        floatingButton.backgroundColor = .trueWhite
        floatingButton.setTitleColor(.trueBlack, for: .normal)
        floatingButton.setTitle(title, for: .normal)


        floatingButton.layer.cornerRadius = 30
//        floatingButton.setTitle(title, for: .normal)
//        floatingButton.setTitle(title, for: .normal)
//        floatingButton.setTitle(title, for: .normal)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false


        return floatingButton
    }
}
