//
//  LoginViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//


import UIKit

class MainViewController: UITabBarController {

    private let childTabs: [UIViewController]

    init(childControllers: [UIViewController]) {
        self.childTabs = childControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true

        viewControllers = childTabs
    }
}
