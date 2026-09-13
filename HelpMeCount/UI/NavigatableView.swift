//
//  NavigatableView.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 13.09.2026.
//

import UIKit

protocol NavigatableView: AnyObject {
    func getNavController() -> UINavigationController?
}
