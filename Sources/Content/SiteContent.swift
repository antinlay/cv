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

struct ProjectCard: Sendable {
    let title: String
    let subtitle: Localized<String>
    let period: String
    let summary: Localized<Variant<String>>
    let bullets: Localized<Variant<[String]>>
    let stack: [String]
    let linkLabel: Localized<String>?
    let linkURL: String?
}

struct ExperienceEntry: Sendable {
    let company: String
    let role: Localized<String>
    let period: String
    let overview: Localized<Variant<String>>
    let highlights: Localized<Variant<[String]>>
    let linkLabel: Localized<String>?
    let linkURL: String?
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
}

enum SiteContent {
    static let profile = ProfileContent(
        name: .init(
            ru: "Александр Ляхевич",
            en: "Alexander Lyakhevich"
        ),
        role: .init(
            ru: "iOS Architecture & SwiftUI Audit Consultant",
            en: "iOS Architecture & SwiftUI Audit Consultant"
        ),
        location: .init(
            ru: "Александр Ляхевич. UTC+3, открыт к удаленным аудитам, спринтам и продуктовым командам.",
            en: "Alexander Lyakhevich. UTC+3, open to remote audits, fix sprints, and product teams."
        ),
        intro: .init(
            ru: .init(
                short: "Нахожу и помогаю исправлять SwiftUI navigation/state/API баги до production: repo audit, risk report и план фиксов для Codex.",
                full: "Нахожу и помогаю исправлять SwiftUI navigation/state/API баги до production: repo audit, архитектурный разбор, performance risks, risk report и план фиксов для Codex. Комфортно двигаюсь от сложного legacy до MVP и App Store delivery."
            ),
            en: .init(
                short: "I find and help fix SwiftUI navigation, state, and API bugs before production: repo audit, risk report, and Codex-ready fix plan.",
                full: "I find and help fix SwiftUI navigation, state, and API bugs before production: repo audit, architecture review, performance risks, risk report, and Codex-ready fix plan. Comfortable from complex legacy codebases to MVP and App Store delivery."
            )
        ),
        statement: .init(
            ru: "Приглашайте на аудит iOS-проекта, performance sprint или MVP, где важны архитектура, скорость и аккуратная поставка.",
            en: "Bring me in for an iOS project audit, performance sprint, or MVP where architecture, velocity, and careful delivery matter."
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
                ru: "iOS Architecture Audit",
                en: "iOS Architecture Audit"
            ),
            summary: .init(
                ru: "Быстрый разбор проекта для команд, которым нужно понять архитектурные, navigation/state и API-риски до релиза.",
                en: "A focused project review for teams that need to see architecture, navigation/state, and API risks before release."
            ),
            points: .init(
                ru: [
                    "Repo review: структура, модули, состояние, навигация",
                    "Async/await, API layer, payload mapping и рискованные сценарии",
                    "Risk report и план фиксов для Codex и команды"
                ],
                en: [
                    "Repo review: structure, modules, state, and navigation",
                    "Async/await, API layer, payload mapping, and risky flows",
                    "Risk report and Codex-ready fix plan for the team"
                ]
            )
        ),
        .init(
            title: .init(
                ru: "SwiftUI Performance Fix Sprint",
                en: "SwiftUI Performance Fix Sprint"
            ),
            summary: .init(
                ru: "Спринт для сложных экранов, где лаги, тяжелые списки, календари или лишние обновления мешают продукту.",
                en: "A sprint for complex screens where lag, heavy lists, calendars, or unnecessary updates slow the product down."
            ),
            points: .init(
                ru: [
                    "Профилирование и поиск реальных узких мест",
                    "Оптимизация списков, календарей и сложных SwiftUI экранов",
                    "Измеримые фиксы и PR-ready изменения"
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
                ru: "AI-assisted iOS MVP Build",
                en: "AI-assisted iOS MVP Build"
            ),
            summary: .init(
                ru: "MVP для стартапов, которым нужна быстрая, но поддерживаемая iOS-поставка с понятным workflow.",
                en: "An MVP track for startups that need fast, maintainable iOS delivery with a clear workflow."
            ),
            points: .init(
                ru: [
                    "SwiftUI MVP, API integration и базовая архитектура",
                    "TestFlight, App Store readiness и release checklist",
                    "AI-assisted delivery workflow без потери инженерного контроля"
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
            title: "Schedbook",
            subtitle: .init(
                ru: "Продуктовый iOS-клиент с нуля",
                en: "Greenfield product iOS app"
            ),
            period: "2024 - 2026",
            summary: .init(
                ru: .init(
                    short: "Архитектура, навигация, auth и offline-first на SwiftData.",
                    full: "Собрал greenfield-приложение с архитектурой, навигацией, auth-потоком, Keychain, refresh-токенами и offline-first слоем на SwiftData."
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
                        "Auth: email/password + Sign in with Apple, Keychain, refresh-токены",
                        "REST + multipart, доменная обработка ошибок и восстановление сессии"
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
            title: "Level / ProSport",
            subtitle: .init(
                ru: "Социальный спорт и real-time chat",
                en: "Sports social product with real-time chat"
            ),
            period: "2024 - 2026",
            summary: .init(
                ru: .init(
                    short: "Миграция чата на SwiftUI с сохранением UIKit-модулей.",
                    full: "Пошагово перевожу продукт на SwiftUI: чат, вложения, статусы и WebSocket lifecycle при сохранении рабочих UIKit-модулей."
                ),
                en: .init(
                    short: "Migrating chat to SwiftUI while keeping UIKit modules stable.",
                    full: "Driving a step-by-step migration to SwiftUI: chat, attachments, statuses, and WebSocket lifecycle while preserving working UIKit modules."
                )
            ),
            bullets: .init(
                ru: .init(
                    short: [
                        "Real-time WebSocket и подготовка sync с watchOS",
                        "Модульные сервисы Auth / Chat / Media / Feed"
                    ],
                    full: [
                        "Real-time WebSocket: статусы, вложения, reconnect и lifecycle",
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
            title: "Wellmate",
            subtitle: .init(
                ru: "Wellness-продукт с модульным ядром",
                en: "Wellness product with a modular core"
            ),
            period: "2024 - 2025",
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
                        "Быстрее добавлять фичи без хаоса в shared code"
                    ],
                    full: [
                        "Масштабируемая структура проекта на SwiftPM",
                        "Повторно используемые UI- и domain-компоненты",
                        "Ускорение feature delivery без хаоса в shared code"
                    ]
                ),
                en: .init(
                    short: [
                        "Scalable project structure",
                        "Faster feature work without shared-code chaos"
                    ],
                    full: [
                        "Scalable project structure built on SwiftPM",
                        "Reusable UI and domain components",
                        "Faster feature delivery without shared-code chaos"
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
            title: "Acti",
            subtitle: .init(
                ru: "KMP-интеграция и iOS-слой",
                en: "KMP integration with a native iOS layer"
            ),
            period: "2024 - 2025",
            summary: .init(
                ru: .init(
                    short: "Интеграция shared/commonMain и iOS-клиента.",
                    full: "Связал iOS-клиент с KMP shared/commonMain, KMP-NativeCoroutines и navigation/state-подходом через Decompose + Koin."
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
                        "Сведение shared-логики и iOS UX без потери нативности"
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
            company: "Schedbook",
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            period: "2024 - 2026",
            overview: .init(
                ru: .init(
                    short: "Greenfield-приложение с auth, навигацией и offline-first.",
                    full: "Greenfield-приложение: архитектура, навигация, auth/refresh, общие компоненты и offline-first слой."
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
                        "Критичные сценарии покрыты базовыми unit/UI тестами"
                    ],
                    full: [
                        "SwiftData и синхронизация UI с локальным кешем",
                        "REST/multipart и доменная обработка ошибок",
                        "Критичные сценарии покрыты unit/UI тестами"
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
            company: "Level / ProSport",
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            period: "2024 - 2026",
            overview: .init(
                ru: .init(
                    short: "SwiftUI-миграция и real-time chat внутри живого продукта.",
                    full: "SwiftUI-миграция и real-time chat внутри живого продукта с сохранением рабочей UIKit-экосистемы."
                ),
                en: .init(
                    short: "SwiftUI migration and real-time chat in a live product.",
                    full: "SwiftUI migration and real-time chat inside a live product while keeping the existing UIKit ecosystem stable."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "WebSocket, вложения, статусы и lifecycle соединения",
                        "Подготовка sync с Apple Watch"
                    ],
                    full: [
                        "WebSocket, вложения, статусы и lifecycle соединения",
                        "Модульные сервисы и подготовка sync с Apple Watch",
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
            company: "Wellmate",
            role: .init(ru: "iOS Developer, part-time", en: "iOS Developer, part-time"),
            period: "2024 - 2025",
            overview: .init(
                ru: .init(
                    short: "Модульная база продукта на SwiftPM.",
                    full: "Модульная база продукта на SwiftPM с общими компонентами и ускорением feature delivery."
                ),
                en: .init(
                    short: "SwiftPM-based modular product foundation.",
                    full: "A SwiftPM-based modular product foundation with shared components and faster feature delivery."
                )
            ),
            highlights: .init(
                ru: .init(
                    short: [
                        "Архитектурные границы и reusable-компоненты",
                        "Снижение регрессий при росте продукта"
                    ],
                    full: [
                        "Архитектурные границы и reusable-компоненты",
                        "Быстрее запускать новые сценарии без переписывания shared-слоя",
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
            company: "Новая Школа / New School",
            role: .init(ru: "iOS Developer", en: "iOS Developer"),
            period: "2023 - 2024",
            overview: .init(
                ru: .init(
                    short: "Фичи, мини-игры, аналитика и AI-диалоги.",
                    full: "Фичи, мини-игры, аналитика, мониторинг и AI-диалоги в образовательном продукте."
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
                        "Подготовка релизов и hot-fix при необходимости"
                    ],
                    full: [
                        "Улучшение UX и стабильности продукта",
                        "Частичная миграция на SwiftUI",
                        "Подготовка релизов и hot-fix при необходимости"
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
            company: "Сбербанк / Sberbank",
            role: .init(ru: "iOS Developer", en: "iOS Developer"),
            period: "2022 - 2023",
            overview: .init(
                ru: .init(
                    short: "Аналитика, design system и стабилизация продукта.",
                    full: "ClickStream-аналитика, внедрение Flamingo design system и стабилизация пользовательских сценариев."
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
                        "Снижение техдолга и поддерживаемость"
                    ],
                    full: [
                        "XCTest на ключевые пользовательские сценарии",
                        "Контроль качества аналитических событий",
                        "Снижение техдолга и поддерживаемость"
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
            title: .init(ru: "Product engineering", en: "Product engineering"),
            items: ["Swift", "SwiftUI", "UIKit", "Swift Concurrency", "AI-assisted delivery"]
        ),
        .init(
            title: .init(ru: "Networking & data", en: "Networking & data"),
            items: ["REST", "WebSocket", "Multipart", "API payload audit", "SwiftData", "Offline-first"]
        ),
        .init(
            title: .init(ru: "Architecture & audit", en: "Architecture & audit"),
            items: ["Repo audit", "SwiftUI state/navigation", "Feature modules", "Coordinators", "DI", "Risk reports"]
        ),
        .init(
            title: .init(ru: "Delivery", en: "Delivery"),
            items: ["Performance profiling", "Codex-ready fix plans", "App Store release", "TestFlight", "XCTest", "Swift Testing"]
        )
    ]

    static let education: [EducationEntry] = [
        .init(
            title: .init(ru: "Школа 21", en: "School 21"),
            note: .init(
                ru: "Swift Bootcamp, командные проекты и code review.",
                en: "Swift Bootcamp, team projects, and code review."
            )
        ),
        .init(
            title: .init(ru: "Essential Developer", en: "Essential Developer"),
            note: .init(
                ru: "iOS Architect, clean architecture и тестирование.",
                en: "iOS Architect, clean architecture, and testing."
            )
        ),
        .init(
            title: .init(ru: "WB Техношкола", en: "WB Tech School"),
            note: .init(
                ru: "Практика инженерной разработки и продуктовой доставки.",
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
