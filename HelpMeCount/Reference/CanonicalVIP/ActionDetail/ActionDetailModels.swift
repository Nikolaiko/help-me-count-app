//
//  ActionDetailModels.swift
//  HelpMeCount
//

import Foundation

enum ActionDetail {
    enum Load {
        struct Request {}
        struct Response {
            let action: CountableAction?
        }
        struct ViewModel {
            let title: String
            let progress: String
        }
    }
}
