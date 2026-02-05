//
//  MainTabBarViewController.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 29.12.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var childTabs: [UIViewController] = []


    init(childTabs: [UIViewController]) {
        self.childTabs = childTabs
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //childTabs.append(ActionsViewController())

        navigationItem.hidesBackButton = true
        setViewControllers(childTabs, animated: true)
    }
}
