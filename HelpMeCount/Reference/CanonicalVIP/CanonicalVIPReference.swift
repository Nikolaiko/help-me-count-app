//
//  CanonicalVIPReference.swift
//  HelpMeCount
//
//  ЭТАЛОННАЯ пара сцен в «книжном» Clean Swift (VIP) — для сравнения с прагматичным
//  роутингом основного приложения. Код компилируется в таргете, но НЕ подключён к живому
//  DI/навигации: это референс, а не рабочий экран.
//
//  Что демонстрирует (чего нет в прагматичном варианте):
//
//  1. Router держит СВОЙ viewController (weak) и навигирует через него:
//         viewController?.navigationController?.pushViewController(...)
//     — без прокидывания `parent: UINavigationController` в каждый метод.
//
//  2. DataStore на Interactor'е + passData в роутере:
//         Interactor: BusinessLogic & DataStore   (состояние сцены живёт в интеракторе)
//         Router:     RoutingLogic & DataPassing   (var dataStore: XDataStore?)
//         routeToDetail(): source.dataStore -> destination.dataStore, затем навигация.
//     Данные между сценами едут через DataStore, а НЕ через общий Service.
//
//  3. View->Router не передаёт полезную нагрузку напрямую: VC просит Interactor
//     зафиксировать выбор в DataStore, а роутер сам его оттуда берёт.
//
//  Поток «выбрали строку -> открылась деталь с этим элементом»:
//
//      ActionsBoardVC.didSelectRow
//        └─ interactor.selectAction(request:)        // -> dataStore.selectedAction
//        └─ router.routeToDetail()
//             ├─ ActionDetailConfigurator.scene()     // собрать сцену назначения
//             ├─ passDataToDetail(source:destination:) // selectedAction -> detail.action
//             └─ viewController?.navigationController?.push(detailVC)
//
//  Прагматичный аналог в проекте: TabControllerRouter — stateless, принимает
//  UINavigationController аргументом, данные шарит через Services. Оба варианта рабочие;
//  канон даёт строгую изоляцию и передачу данных «сцена→сцена», ценой большего бойлерплейта.
//

import Foundation

enum CanonicalVIPReference {}
