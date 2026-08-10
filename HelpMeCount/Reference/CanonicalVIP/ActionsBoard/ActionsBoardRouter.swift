//
//  ActionsBoardRouter.swift
//  HelpMeCount
//
//  СЕРДЦЕ каноничного VIP-роутинга. Router:
//   • держит СВОЙ viewController (weak) и навигирует через него — без parent-аргумента;
//   • держит dataStore своей сцены (DataPassing) и на переходе перекладывает данные
//     из своего DataStore в DataStore сцены назначения (passDataToXxx).
//
//  Сравни с прагматичным TabControllerRouter: там роутер stateless, принимает
//  UINavigationController аргументом, а данные шарятся через Services.
//

import UIKit

protocol ActionsBoardRoutingLogic {
    func routeToDetail()
}

protocol ActionsBoardDataPassing {
    var dataStore: ActionsBoardDataStore? { get }
}

final class ActionsBoardRouter: ActionsBoardRoutingLogic, ActionsBoardDataPassing {
    weak var viewController: ActionsBoardViewController?
    var dataStore: ActionsBoardDataStore?

    // MARK: - Routing
    func routeToDetail() {
        let destination = ActionDetailConfigurator.scene()

        // 1) переложить данные: source.DataStore -> destination.DataStore
        if var destinationDS = destination.router.dataStore {
            passDataToDetail(source: dataStore, destination: &destinationDS)
        }

        // 2) навигация через собственный viewController, БЕЗ parent-аргумента
        navigateToDetail(destination: destination.viewController)
    }

    // MARK: - Navigation
    private func navigateToDetail(destination: ActionDetailViewController) {
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data
    private func passDataToDetail(source: ActionsBoardDataStore?,
                                  destination: inout ActionDetailDataStore) {
        destination.action = source?.selectedAction
    }
}
