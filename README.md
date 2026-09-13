# HelpMeCount

iOS-приложение для отслеживания повторяющихся действий (привычек): создаёте действие с целевым
количеством повторений, отмечаете прогресс на главном экране, входите/регистрируетесь по
логину и паролю, данные синхронизируются с бэкендом и кэшируются локально.

## Стек

- **Swift 5**, **UIKit** (без SwiftUI/Storyboard — вёрстка кодом)
- **SnapKit** — единственная внешняя зависимость, подключена через Swift Package Manager
- **Combine** — реактивные обновления списка действий (`contextPublisher`)
- **SwiftData** — локальное хранилище действий; **UserDefaults** — хранилище токена авторизации
- Минимальная версия — **iOS 18.5**

Зависимостей никаких дополнительно ставить не нужно: SPM подтянет SnapKit сам при первом
открытии проекта в Xcode.

## Быстрый старт

```bash
open HelpMeCount.xcodeproj
```

Схема — `HelpMeCount`, таргет один. Дождаться резолва пакетов SPM и запустить на симуляторе.
Тестового таргета в проекте пока нет.

## Архитектура

Экраны написаны по паттерну **VIP (Clean Swift)**: `View ⇄ Interactor ⇄ Presenter`, навигация
вынесена в отдельный **Router**. У каждого юзкейса экрана — свой набор моделей
`Request`/`Response`/`ViewData` (например, [RefreshActions.swift](HelpMeCount/Features/MainFeature/ActionsTab/ActionsList/ActionsListModels/RefreshActions.swift)), это исключает разрастание
методов интерактора/презентера произвольными параметрами.

Поток данных на примере списка действий:

```
ActionsViewController          ActionsTabInteractor           ActionsTabPresenter
   (View)          --request-->     (Interactor)     --response-->    (Presenter)
       ^                                 |                                 |
       |                              Worker                               |
       |                       (сеть + локальное хранилище)                |
       +---------------------------- viewData <--------------------------- +
```

- **View** (`...ViewController`) — только отображение и сбор пользовательского ввода, ничего не знает о сети/хранилище.
- **Interactor** — бизнес-логика экрана, дергает **Worker** (или сервисы напрямую), собирает `Response`.
- **Presenter** — конвертирует `Response` в `ViewData` и вызывает методы `View`.
- **Worker** (есть не на всех экранах, см. [ActionsListWorker.swift](HelpMeCount/Features/MainFeature/ActionsTab/ActionsList/Worker/ActionsListWorker.swift)) — прослойка между интерактором и `NetworkService`/`LocalActionsStorage`, публикует изменения через Combine.

### Навигация (Router)

У каждого экрана — собственный протокол-роутер и его реализация `...ViewControllerRouter`
(см. [ActionsListRouter.swift](HelpMeCount/Features/MainFeature/ActionsTab/ActionsList/Router/ActionsListRouter.swift) / [ActionsViewControllerRouter.swift](HelpMeCount/Features/MainFeature/ActionsTab/ActionsList/Router/ActionsViewControllerRouter.swift)) — общего роутера на все экраны
больше нет. Правила:

- Роутер хранит `weak var controller: ...View?` и достаёт `UINavigationController` через
  `controller?.getNavController()` — параметр `parent:` в сигнатуры не передаётся.
- `getNavController()` объявлен один раз в общем протоколе [NavigatableView.swift](HelpMeCount/UI/NavigatableView.swift), View-протокол экрана просто его наследует.
- Если нав-контроллера нет, метод роутера кидает `NavigationErrors.parentNotFound`
  ([NavigationErrors.swift](HelpMeCount/Model/Errors/NavigationErrors.swift)); вызывающий код в `ViewController` оборачивает вызов в `do/catch` и
  показывает алерт, а не молча ничего не делает.
- Конкретный роутер создаётся и связывается с view в момент сборки экрана в `AppFactory`
  (`router.controller = view`), а не через параметр конструктора view.

Заводя новый экран — ориентируйтесь на пару `ActionsList`/`AddAction`, это референсная
реализация паттерна.

### DI и сборка экранов

Своего DI-фреймворка нет, сборка — руками через две фабрики:

- [ServiceFactory.swift](HelpMeCount/AppComposition/ServiceFactory.swift) — синглтон-подобный набор сервисов уровня приложения (токен-стораж, стораж
  действий, сетевой клиент), создаётся один раз в `SceneDelegate`.
- [AppFactory.swift](HelpMeCount/AppComposition/AppFactory.swift) — собирает конкретный экран (View + Interactor + Presenter + Router) и
  передаёт ему нужные сервисы из `ServiceFactory`. Разбит на протоколы
  `AppRootSceneFactory` / `AuthorizedSceneFactory` / `MainSceneFactory`, чтобы роутер каждого
  фичи-модуля видел только то, что ему нужно для навигации дальше.

Точка входа — [SceneDelegate.swift](HelpMeCount/SceneDelegate.swift): создаёт `AppFactory`, оборачивает корневой экран
(`AppRootViewController`) в единый `UINavigationController` на всё приложение (таб-бар и все
экраны внутри него пушатся в этот же общий стек, отдельного nav-контроллера на таб не заводится).

### Сеть и локальное хранилище

- `NetworkService` ([NetworkService.swift](HelpMeCount/Services/NetworkService/NetworkService.swift)) — протокол с доменными методами (`loginUser`, `getActions` и т.д.),
  реализация `GeneratedAPI` оборачивает клиент, сгенерированный OpenAPI Generator'ом
  (`HelpMeCount/Services/NetworkService/GeneratedNetworkLayer`), и мапит generated-модели в
  доменные (`HelpMeCount/Model/Mappers.swift`).
- `LocalActionsStorage` — SwiftData (`SwiftDataStorage`), `LocalTokensStorage` — UserDefaults
  (`UserDefaultsStorage`). Оба спрятаны за протоколами в `HelpMeCount/Services/LocalStorageService`,
  так что реализацию можно подменить, не трогая интеракторы.

## Структура проекта

```
HelpMeCount/
  AppComposition/       AppFactory, ServiceFactory — сборка приложения и экранов
  Features/
    AppRootFeature/      экран-роутер: решает, показать Login или таб-бар
    AuthorizationFeature/ Login, Register
    MainFeature/          таб-бар: ActionsTab (список действий, добавление), ProfileTab
  Model/                 доменные модели, мапперы, ошибки, SwiftData-схемы
  Services/               NetworkService (+ сгенерированный OpenAPI-клиент), LocalStorageService
  UI/                     переиспользуемые View-компоненты, цвета, шрифты, базовые контроллеры
Modules/                 локальные SPM-пакеты (CommonModels, PersistendDataStorage) —
                          пока не подключены к таргету HelpMeCount, задел на будущее
Specs/                    исходники для генерации OpenAPI-клиента (spec.yaml + generate.sh)
```

Каждая фича внутри `Features` следует одной и той же раскладке:
`View/`, `Interactor/`, `Presenter/`, `Router/`, `<Feature>Models/`.

## Конвенции

- Экран показывает алерт об ошибке сам (`BaseController.showErrorAlert`/`showDIError`),
  а не пробрасывает ошибку выше.
- У каждого юзкейса экрана — свои `Request`/`Response`/`ViewData`, даже если поля дублируются
  между соседними use case'ами — не стоит их объединять ради экономии строк.
- Дебажные `print` не должны попадать в `main`/`develop` — используйте точечный breakpoint или
  временно оставляйте их только в фиче-ветке.
