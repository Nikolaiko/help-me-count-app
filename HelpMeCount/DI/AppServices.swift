//
//  AppServices.swift
//  HelpMeCount
//
//  Created by Nikolai Baklanov on 30.08.2026.
//

import Foundation

/// Общие сервисы приложения, собираемые один раз в точке входа (SceneDelegate)
/// и прокидываемые дальше конструкторами через конфигураторы и роутеры каждой сцены.
///
/// Никакого контейнера и рантайм-резолва: это самописный DI, канонический для
/// Clean Swift — конфигуратор сцены сам создаёт View/Interactor/Presenter/Router/Worker
/// и передаёт им нужные зависимости через init.
struct AppServices {
    let networkService: NetworkService
    let tokensStorage: LocalTokensStorage
    let actionsStorage: LocalActionsStorage
}
