//
//  RobotoFont.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 20.12.2025.
//

import UIKit

extension UIFont {
    enum Roboto {
        public static func bold(size: CGFloat) -> UIFont? {
            UIFont(name: "Roboto-Bold", size: size)
        }

        public static func regular(size: CGFloat) -> UIFont? {
            UIFont(name: "Roboto-Regular", size: size)
        }
    }
}
