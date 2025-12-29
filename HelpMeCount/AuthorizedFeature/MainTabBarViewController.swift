//
//  MainTabBarViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var childTabs: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        setViewControllers(childTabs, animated: true)
    }
}
