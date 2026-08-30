//
//  BaseController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 31.12.2025.
//

import UIKit

class BaseController: UIViewController {

    func showErrorAlert(title: String, subtitle: String? = nil) {
        guard !(presentedViewController is UIAlertController) else { return }

        let alert = UIAlertController(title: title,
                                      message: subtitle,
                                      preferredStyle: .alert)

        present(alert, animated: true)
    }
}
