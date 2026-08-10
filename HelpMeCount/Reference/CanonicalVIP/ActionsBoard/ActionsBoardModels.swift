//
//  ActionsBoardModels.swift
//  HelpMeCount
//
//  Canonical Clean Swift reference scene (source of navigation).
//  Не подключена к живому DI — существует для сравнения с прагматичным роутингом.
//

import Foundation

enum ActionsBoard {
    // Use case: загрузить список
    enum Load {
        struct Request {}
        struct Response {
            let actions: [CountableAction]
        }
        struct ViewModel {
            struct Row {
                let title: String
                let progress: String
            }
            let rows: [Row]
        }
    }

    // Use case: выбрать элемент (кладём выбор в DataStore, данные не улетают наружу)
    enum Select {
        struct Request {
            let index: Int
        }
    }
}
