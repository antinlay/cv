import Foundation

enum CVLanguage: String, CaseIterable, Sendable {
    case ru
    case en
}

enum CVLength: String, CaseIterable, Sendable {
    case short
    case full
}

struct Localized<Value: Sendable>: Sendable {
    let ru: Value
    let en: Value

    func value(for language: CVLanguage) -> Value {
        switch language {
        case .ru:
            ru
        case .en:
            en
        }
    }
}

struct Variant<Value: Sendable>: Sendable {
    let short: Value
    let full: Value

    func value(for length: CVLength) -> Value {
        switch length {
        case .short:
            short
        case .full:
            full
        }
    }
}

struct ProfileContent: Sendable {
    let name: Localized<String>
    let role: Localized<String>
    let location: Localized<String>
    let intro: Localized<Variant<String>>
    let statement: Localized<String>
}

struct ContactItem: Sendable {
    let label: Localized<String>
    let value: String
    let href: String?
}

struct WorkIdentity: Sendable {
    let title: String
    let period: String
}

enum WorkIdentities {
    static let schedbook = WorkIdentity(title: "Schedbook", period: "2024 - 2026")
    static let level = WorkIdentity(title: "Level / ProSport", period: "2024 - 2026")
    static let wellmate = WorkIdentity(title: "Wellmate", period: "2024 - 2025")
    static let acti = WorkIdentity(title: "Acti", period: "2024 - 2025")
    static let newSchool = WorkIdentity(title: "Новая Школа / New School", period: "2023 - 2024")
    static let sberbank = WorkIdentity(title: "Сбербанк / Sberbank", period: "2022 - 2023")
}

struct ProjectCard: Sendable {
    let identity: WorkIdentity
    let subtitle: Localized<String>
    let summary: Localized<Variant<String>>
    let bullets: Localized<Variant<[String]>>
    let stack: [String]
    let linkLabel: Localized<String>?
    let linkURL: String?

    var title: String { identity.title }
    var period: String { identity.period }
}

struct ExperienceEntry: Sendable {
    let identity: WorkIdentity
    let role: Localized<String>
    let overview: Localized<Variant<String>>
    let highlights: Localized<Variant<[String]>>
    let linkLabel: Localized<String>?
    let linkURL: String?

    var company: String { identity.title }
    var period: String { identity.period }
}

struct SkillGroup: Sendable {
    let title: Localized<String>
    let items: [String]
}

struct ServiceOffering: Sendable {
    let title: Localized<String>
    let summary: Localized<String>
    let points: Localized<[String]>
}

struct EducationEntry: Sendable {
    let title: Localized<String>
    let note: Localized<String>
}

enum SitePaths {
    static let base = "/cv"
    static let resume = "\(base)/resume/"
    static let avatar = "\(base)/images/avatar.jpg?v=20260521"
    static let favicon = "\(base)/images/favicon.svg"
    static let siteURL = "https://antinlay.github.io\(base)/"
}

enum SiteContent {
    static let profile = ProfileContent(
        name: .init(
            ru: "Александр Ляхевич",
            en: "Alexander Lyakhevich"
        ),
        role: .init(
            ru: "iOS Product Engineer · Swift / SwiftUI",
            en: "iOS Product Engineer · Swift / SwiftUI"
        ),
        location: .init(
            ru: "Открыт к удалённой работе в продуктовой команде.",
            en: "Open to remote work on a product team."
        ),
        intro: .init(
            ru: .init(
                short: "Разрабатываю iOS-приложения с нуля и развиваю выпущенные продукты. Проектирую архитектуру, подключаю API, пишу тесты и готовлю релизы в App Store.",
                full: "Разрабатываю iOS-приложения с нуля и развиваю выпущенные продукты. В Schedbook спроектировал архитектуру iOS-клиента, реализовал вход, подключил REST API и добавил офлайн-кеш на SwiftData. В Level / ProSport внедрял SwiftUI в существующий UIKit-продукт и разрабатывал чат на WebSocket."
            ),
            en: .init(
                short: "I build iOS apps from scratch and develop live products. My work covers architecture, APIs, testing, and App Store releases.",
                full: "I build iOS apps from scratch and develop live products. For Schedbook, I designed the iOS architecture, implemented sign-in, integrated a REST API, and built an offline cache with SwiftData. At Level / ProSport, I introduced SwiftUI into an existing UIKit app and built WebSocket chat."
            )
        ),
        statement: .init(
            ru: "Использую AI-инструменты для разбора кода и подготовки изменений, проверяю результат ревью и тестами.",
            en: "I use AI tools to explore code and prepare changes, then verify the results through review and tests."
        )
    )

    static let contacts: [ContactItem] = [
        .init(label: .init(ru: "Почта", en: "Email"), value: "aolyakhevich@icloud.com", href: "mailto:aolyakhevich@icloud.com"),
        .init(label: .init(ru: "Telegram", en: "Telegram"), value: "t.me/lyabowski", href: "https://t.me/lyabowski"),
        .init(label: .init(ru: "Часовой пояс", en: "Time zone"), value: "UTC+3 (Moscow)", href: nil),
        .init(label: .init(ru: "English", en: "English"), value: "B1", href: nil)
    ]

    static let services: [ServiceOffering] = [
        .init(
            title: .init(
                ru: "Аудит архитектуры iOS",
                en: "iOS Architecture Review"
            ),
            summary: .init(
                ru: "Проверю архитектуру, навигацию, управление состоянием и работу с API перед релизом.",
                en: "A focused project review for teams that need to see architecture, navigation/state, and API risks before release."
            ),
            points: .init(
                ru: [
                    "Структура проекта, модули, состояние и навигация",
                    "Асинхронный код, сетевой слой и преобразование данных API",
                    "Отчёт о рисках и план исправлений"
                ],
                en: [
                    "Repo review: structure, modules, state, and navigation",
                    "Async/await, API layer, payload mapping, and risky flows",
                    "Risk report and remediation plan"
                ]
            )
        ),
        .init(
            title: .init(
                ru: "Оптимизация SwiftUI",
                en: "SwiftUI Performance"
            ),
            summary: .init(
                ru: "Выясню, почему тормозят списки, календари и другие сложные экраны.",
                en: "A sprint for complex screens where lag, heavy lists, calendars, or unnecessary updates slow the product down."
            ),
            points: .init(
                ru: [
                    "Профилирование и поиск реальных узких мест",
                    "Оптимизация списков, календарей и сложных SwiftUI экранов",
                    "Исправления с замерами до и после"
                ],
                en: [
                    "Profiling and finding real bottlenecks",
                    "Optimizing lists, calendars, and complex SwiftUI screens",
                    "Measurable fixes and PR-ready changes"
                ]
            )
        ),
        .init(
            title: .init(
                ru: "Разработка первой версии iOS-приложения",
                en: "iOS MVP Development"
            ),
            summary: .init(
                ru: "Разработаю первую версию приложения и подготовлю её к тестированию и публикации.",
                en: "An MVP track for startups that need fast, maintainable iOS delivery with a clear workflow."
            ),
            points: .init(
                ru: [
                    "Интерфейс на SwiftUI, интеграция API и архитектура приложения",
                    "Сборка в TestFlight и подготовка к публикации в App Store",
                    "Использование ИИ с проверкой кода и тестами"
                ],
                en: [
                    "SwiftUI MVP, API integration, and baseline architecture",
                    "TestFlight, App Store readiness, and release checklist",
                    "AI-assisted delivery workflow without losing engineering control"
                ]
            )
        )
    ]

    static let projects: [ProjectCard] = [
        .init(
            identity: WorkIdentities.schedbook,
            subtitle: .init(
                ru: "Продуктовый iOS-клиент с нуля",
                en: "Greenfield product iOS app"
            ),
            summary: .init(
                ru: .init(
                    short: "Разработал iOS-клиент с нуля на SwiftUI и SwiftData.",
                    full: "Разработал iOS-клиент на SwiftUI. Спроектировал навигацию, реализовал вход и восстановление сессии, добавил локальный кеш на SwiftData."
                ),
                en: .init(
                    short: "Architecture, navigation, auth, and offline-first with SwiftData.",
                    full: "Built a greenfield app with architecture, navigation, auth flow, Keychain, refresh tokens, and an offline-first data layer powered by SwiftData."
                )
            ),
            bullets: .init(
                ru: .init(
                    short: [
                        "Модульная инфраструктура и общие компоненты",
                        "REST + multipart, локальный кеш и восстановление сессии"
                    ],
                    full: [
                        "Модульная инфраструктура и общие компоненты для ускорения фич",
                        "Вход по почте и через Apple, хранение токенов в Keychain и обновление сессии",
                        "Интеграция с REST API, multipart-запросы и обработка ошибок"
                    ]
                ),
                en: .init(
                    short: [
                        "Modular infrastructure and shared components",
                        "REST + multipart, local cache, and session restore"
                    ],
                    full: [
                        "Modular infrastructure and shared components to accelerate delivery",
                        "Auth: email/password + Sign in with Apple, Keychain, refresh tokens",
                        "REST + multipart, domain error handling, and session restore"
                    ]
                )
            ),
            stack: ["SwiftUI", "SwiftData", "Networking", "Keychain"],
            linkLabel: nil,
            linkURL: nil
        ),
        .init(
            identity: WorkIdentities.level,
            subtitle: .init(
                ru: "Социальная сеть для спорта",
                en: "Social app for sports"
            ),
            summary: .init(
                ru: .init(
                    short: "Миграция чата на SwiftUI с сохранением UIKit-модулей.",
                    full: "Переводил чат действующего приложения на SwiftUI, сохранив модули на UIKit. Работал со статусами, вложениями и переподключением WebSocket."
                ),
                en: .init(
                    short: "Migrating chat to SwiftUI while keeping UIKit modules stable.",
                    full: "Driving a step-by-step migration to SwiftUI: chat, attachments, statuses, and WebSocket lifecycle while preserving working UIKit modules."
                )
            ),
            bullets: .init(
                ru: .init(
                    short: [
                        "Чат на WebSocket и подготовка синхронизации с Apple Watch",
                        "Модульные сервисы Auth / Chat / Media / Feed"
                    ],
                    full: [
                        "Статусы и вложения в чате, управление соединением и переподключение WebSocket",
                        "Подготовка синхронизации с Apple Watch",
                        "Модульные сервисы Auth / Chat / Media / Feed / Event"
                    ]
                ),
                en: .init(
                    short: [
                        "Real-time WebSocket and watchOS sync groundwork",
                        "Modular services for Auth / Chat / Media / Feed"
                    ],
                    full: [
                        "Real-time WebSocket: statuses, attachments, reconnect, and lifecycle",
                        "Groundwork for Apple Watch synchronization",
                        "Modular services for Auth / Chat / Media / Feed / Event"
                    ]
                )
            ),
            stack: ["SwiftUI", "UIKit", "WebSocket", "Modular services"],
            linkLabel: .init(
                ru: "Открыть в App Store",
                en: "Open in App Store"
            ),
            linkURL: "https://apps.apple.com/ru/app/%D1%83%D1%80%D0%BE%D0%B2%D0%B5%D0%BD%D1%8C-%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%B8%D0%B2%D0%BD%D0%B0%D1%8F-%D1%81%D0%B5%D1%82%D1%8C/id1577083239"
        ),
        .init(
            identity: WorkIdentities.wellmate,
            subtitle: .init(
                ru: "Приложение о питании",
                en: "Nutrition app"
            ),
            summary: .init(
                ru: .init(
                    short: "SwiftPM-модули и общие компоненты для ускорения поставки.",
                    full: "Выстроил модульные границы и общие компоненты на SwiftPM, чтобы ускорить поставку новых сценариев и уменьшить регрессии."
                ),
                en: .init(
                    short: "SwiftPM modules and shared components for faster delivery.",
                    full: "Defined module boundaries and shared components with SwiftPM to speed up new feature delivery and reduce regressions."
                )
            ),
            bullets: .init(
                ru: .init(
                    short: [
                        "Масштабируемая структура проекта",
                        "Общие компоненты для новых экранов"
                    ],
                    full: [
                        "Масштабируемая структура проекта на SwiftPM",
                        "Повторно используемые UI- и domain-компоненты",
                        "Новые сценарии без переработки общих компонентов"
                    ]
                ),
                en: .init(
                    short: [
                        "Scalable project structure",
                        "Shared components for new screens"
                    ],
                    full: [
                        "Scalable project structure built on SwiftPM",
                        "Reusable UI and domain components",
                        "New flows without reworking shared components"
                    ]
                )
            ),
            stack: ["SwiftPM", "UIKit", "Shared UI", "Architecture"],
            linkLabel: .init(
                ru: "Открыть в App Store",
                en: "Open in App Store"
            ),
            linkURL: "https://apps.apple.com/ru/app/wellmate-ai-nutritionist/id6468350840"
        ),
        .init(
            identity: WorkIdentities.acti,
            subtitle: .init(
                ru: "KMP-интеграция и iOS-слой",
                en: "KMP integration with a native iOS layer"
            ),
            summary: .init(
                ru: .init(
                    short: "Интеграция shared/commonMain и iOS-клиента.",
                    full: "Подключил общую логику Kotlin Multiplatform к iOS-клиенту. Использовал KMP-NativeCoroutines, Decompose и Koin для интеграции асинхронного кода, состояния и навигации."
                ),
                en: .init(
                    short: "Integrated shared/commonMain with the iOS client.",
                    full: "Integrated the iOS client with KMP shared/commonMain, KMP-NativeCoroutines, and Decompose + Koin based navigation/state."
                )
            ),
            bullets: .init(
                ru: .init(
                    short: [
                        "KMP-NativeCoroutines и слой интеграции",
                        "Decompose + Koin для состояния и навигации"
                    ],
                    full: [
                        "KMP-NativeCoroutines и слой интеграции на iOS",
                        "Decompose + Koin для состояния и навигации",
                        "Общая логика Kotlin Multiplatform и нативный интерфейс iOS"
                    ]
                ),
                en: .init(
                    short: [
                        "KMP-NativeCoroutines integration layer",
                        "Decompose + Koin for state and navigation"
                    ],
                    full: [
                        "KMP-NativeCoroutines integration layer on iOS",
                        "Decompose + Koin for state and navigation",
                        "Bridged shared logic with native iOS UX without losing platform feel"
                    ]
                )
            ),
            stack: ["KMP", "Swift", "Decompose", "Koin"],
            linkLabel: .init(
                ru: "Открыть в App Store",
                en: "Open in App Store"
            ),
            linkURL: "https://apps.apple.com/ru/app/acti/id6747684005"
        )
    ]

    static let experience: [ExperienceEntry] = [
        .init(
            identity: WorkIdentities.schedbook,
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            overview: .init(
                ru: .init(
                    short: "Разработка iOS-клиента с нуля: вход, навигация и офлайн-кеш.",
                    full: "Спроектировал архитектуру и навигацию iOS-клиента, реализовал вход, обновление сессии и локальный кеш."
                ),
                en: .init(
                    short: "Greenfield app with auth, navigation, and offline-first architecture.",
                    full: "Greenfield app covering architecture, navigation, auth/refresh, shared components, and an offline-first data layer."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "SwiftData и синхронизация UI с локальным кешем",
                        "Написал модульные и UI-тесты для ключевых сценариев"
                    ],
                    full: [
                        "SwiftData и синхронизация UI с локальным кешем",
                        "REST/multipart и доменная обработка ошибок",
                        "Написал модульные и UI-тесты для ключевых сценариев"
                    ]
                ),
                en: .init(
                    short: [
                        "SwiftData with UI synced to local cache",
                        "Critical flows covered by baseline unit/UI tests"
                    ],
                    full: [
                        "SwiftData with UI synchronized to a local cache",
                        "REST/multipart and domain-level error handling",
                        "Critical flows covered by unit/UI tests"
                    ]
                )
            ),
            linkLabel: nil,
            linkURL: nil
        ),
        .init(
            identity: WorkIdentities.level,
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            overview: .init(
                ru: .init(
                    short: "Миграция чата действующего приложения на SwiftUI.",
                    full: "Переводил чат на SwiftUI поэтапно, сохраняя совместимость с существующими экранами на UIKit."
                ),
                en: .init(
                    short: "SwiftUI migration and real-time chat in a live product.",
                    full: "SwiftUI migration and real-time chat inside a live product while keeping the existing UIKit ecosystem stable."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "Вложения, статусы и управление соединением WebSocket",
                        "Подготовка синхронизации с Apple Watch"
                    ],
                    full: [
                        "Вложения, статусы и управление соединением WebSocket",
                        "Модульные сервисы и подготовка синхронизации с Apple Watch",
                        "Релизная стабильность в App Store"
                    ]
                ),
                en: .init(
                    short: [
                        "WebSocket, attachments, statuses, and connection lifecycle",
                        "Groundwork for Apple Watch sync"
                    ],
                    full: [
                        "WebSocket, attachments, statuses, and connection lifecycle",
                        "Modular services and groundwork for Apple Watch sync",
                        "Release stability in the App Store"
                    ]
                )
            ),
            linkLabel: .init(ru: "App Store", en: "App Store"),
            linkURL: "https://apps.apple.com/ru/app/%D1%83%D1%80%D0%BE%D0%B2%D0%B5%D0%BD%D1%8C-%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%B8%D0%B2%D0%BD%D0%B0%D1%8F-%D1%81%D0%B5%D1%82%D1%8C/id1577083239"
        ),
        .init(
            identity: WorkIdentities.wellmate,
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            overview: .init(
                ru: .init(
                    short: "Модульная база продукта на SwiftPM.",
                    full: "Разделил код на модули SwiftPM и выделил общие компоненты для новых функций."
                ),
                en: .init(
                    short: "SwiftPM-based modular product foundation.",
                    full: "A SwiftPM-based modular product foundation with shared components and faster feature delivery."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "Разделение кода на модули и общие компоненты",
                        "Снижение регрессий при росте продукта"
                    ],
                    full: [
                        "Разделение кода на модули и общие компоненты",
                        "Добавление сценариев без переработки общего кода",
                        "Снижение регрессий при росте продукта"
                    ]
                ),
                en: .init(
                    short: [
                        "Architectural boundaries and reusable components",
                        "Lower regression risk while the product grows"
                    ],
                    full: [
                        "Architectural boundaries and reusable components",
                        "Faster launch of new flows without rewriting shared layers",
                        "Lower regression risk while the product grows"
                    ]
                )
            ),
            linkLabel: .init(ru: "App Store", en: "App Store"),
            linkURL: "https://apps.apple.com/ru/app/wellmate-ai-nutritionist/id6468350840"
        ),
        .init(
            identity: WorkIdentities.newSchool,
            role: .init(ru: "iOS Developer", en: "iOS Developer"),
            overview: .init(
                ru: .init(
                    short: "Мини-игры, диалоги с ИИ и аналитика.",
                    full: "Разрабатывал мини-игры и диалоги с ИИ для образовательного приложения, работал с аналитикой и мониторингом."
                ),
                en: .init(
                    short: "Features, mini-games, analytics, and AI dialogs.",
                    full: "Features, mini-games, analytics, monitoring, and AI dialogs for an education product."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "Улучшение UX и стабильности",
                        "Подготовка релизов в App Store и выпуск срочных исправлений"
                    ],
                    full: [
                        "Улучшение UX и стабильности продукта",
                        "Частичная миграция на SwiftUI",
                        "Подготовка релизов в App Store и выпуск срочных исправлений"
                    ]
                ),
                en: .init(
                    short: [
                        "Improved UX and stability",
                        "App Store releases with hot-fixes when needed"
                    ],
                    full: [
                        "Improved product UX and stability",
                        "Partial SwiftUI migration",
                        "App Store releases with hot-fixes when needed"
                    ]
                )
            ),
            linkLabel: .init(ru: "App Store", en: "App Store"),
            linkURL: "https://apps.apple.com/ru/developer/the-new-school-limited-liability-company/id1622694692"
        ),
        .init(
            identity: WorkIdentities.sberbank,
            role: .init(ru: "iOS Developer", en: "iOS Developer"),
            overview: .init(
                ru: .init(
                    short: "Аналитика, дизайн-система и тестирование.",
                    full: "Внедрял дизайн-систему Flamingo, работал с аналитикой ClickStream и тестировал ключевые сценарии."
                ),
                en: .init(
                    short: "Analytics, design system rollout, and product stabilization.",
                    full: "ClickStream analytics, Flamingo design system rollout, and stabilization of important user flows."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "XCTest на ключевые сценарии",
                        "Сокращение технического долга"
                    ],
                    full: [
                        "XCTest на ключевые пользовательские сценарии",
                        "Контроль качества аналитических событий",
                        "Сокращение технического долга"
                    ]
                ),
                en: .init(
                    short: [
                        "XCTest for key flows",
                        "Tech debt reduction and maintainability"
                    ],
                    full: [
                        "XCTest for key user flows",
                        "Analytics event quality control",
                        "Tech debt reduction and maintainability"
                    ]
                )
            ),
            linkLabel: nil,
            linkURL: nil
        )
    ]

    static let skills: [SkillGroup] = [
        .init(
            title: .init(ru: "Разработка iOS", en: "Product engineering"),
            items: ["Swift", "SwiftUI", "UIKit", "Swift Concurrency", "AI-assisted delivery"]
        ),
        .init(
            title: .init(ru: "Сеть и данные", en: "Networking & data"),
            items: ["REST", "WebSocket", "Multipart", "API payload audit", "SwiftData", "Offline-first"]
        ),
        .init(
            title: .init(ru: "Архитектура", en: "Architecture & audit"),
            items: ["Repo audit", "SwiftUI state/navigation", "Feature modules", "Coordinators", "DI", "Risk reports"]
        ),
        .init(
            title: .init(ru: "Тестирование и релизы", en: "Delivery"),
            items: ["Performance profiling", "App Store release", "TestFlight", "XCTest", "Swift Testing"]
        )
    ]

    static let education: [EducationEntry] = [
        .init(
            title: .init(ru: "Школа 21", en: "School 21"),
            note: .init(
                ru: "Интенсив по Swift, командные проекты и ревью кода.",
                en: "Swift Bootcamp, team projects, and code review."
            )
        ),
        .init(
            title: .init(ru: "Essential Developer", en: "Essential Developer"),
            note: .init(
                ru: "Курс iOS Architect: чистая архитектура и тестирование.",
                en: "iOS Architect, clean architecture, and testing."
            )
        ),
        .init(
            title: .init(ru: "WB Техношкола", en: "WB Tech School"),
            note: .init(
                ru: "Практика разработки и выпуска продукта.",
                en: "Hands-on engineering practice and product delivery."
            )
        ),
        .init(
            title: .init(ru: "ВятГУ", en: "Vyatka State University"),
            note: .init(
                ru: "2010 - 2015",
                en: "2010 - 2015"
            )
        )
    ]
}
