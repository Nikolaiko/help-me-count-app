//
//  DBUpdateListener.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 08.02.2026.
//

import Foundation

protocol DBUpdateListener: AnyObject {
    func databaseUpdated()
}
