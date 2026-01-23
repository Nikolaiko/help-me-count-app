//
//  BaseController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 28.12.2025.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true        
        view.backgroundColor = .white
    }

    public func showAlert(title: String, message: String? = nil) {
        guard self.presentedViewController == nil else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }

    public func showAlertUnknownError() {
        showAlert(title: "Неизвестная ошибка")
    }
}
