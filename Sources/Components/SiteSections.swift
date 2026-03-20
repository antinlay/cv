import Foundation
import Ignite

struct TopBar: HTML {
    var body: some HTML {
        Tag("header") {
            Tag("div") {
                Tag("a") {
                    "AL"
                }
                .attribute("href", "#top")
                .class("brand-mark")

                Tag("nav") {
                    ForEach(CVLanguage.allCases) { language in
                        Tag("a") { language == .ru ? "Кейсы" : "Work" }
                            .attribute("href", "#work")
                            .attribute("data-lang", language.rawValue)
                            .class("top-link")
                    }
                    ForEach(CVLanguage.allCases) { language in
                        Tag("a") { language == .ru ? "Опыт" : "Experience" }
                            .attribute("href", "#experience")
                            .attribute("data-lang", language.rawValue)
                            .class("top-link")
                    }
                    ForEach(CVLanguage.allCases) { language in
                        Tag("a") { language == .ru ? "Стек" : "Stack" }
                            .attribute("href", "#stack")
                            .attribute("data-lang", language.rawValue)
                            .class("top-link")
                    }
                    ForEach(CVLanguage.allCases) { language in
                        Tag("a") { language == .ru ? "Контакты" : "Contacts" }
                            .attribute("href", "#contact")
                            .attribute("data-lang", language.rawValue)
                            .class("top-link")
                    }
                }
                .class("top-nav")

                Tag("div") {
                    LanguageToggle(className: "state-group state-group-compact")
                }
                .class("top-controls")
            }
            .class("topbar-inner")
        }
        .class("topbar")
    }
}

struct HeroSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                Tag("span") {
                    "iOS / Swift / Product Engineering"
                }
                .class("eyebrow")

                LocalizedTextBlock("h1", content: SiteContent.profile.name, classNames: ["hero-title"])
                LocalizedTextBlock("p", content: SiteContent.profile.role, classNames: ["hero-role"])
                LocalizedVariantTextBlock("p", content: SiteContent.profile.intro, classNames: ["hero-copy"])

                Tag("div") {
                    ForEach(CVLanguage.allCases) { language in
                        Link(
                            language == .ru ? "Открыть резюме" : "Open resume",
                            target: SitePaths.resume
                        )
                        .class("cta-button", "cta-primary")
                        .attribute("data-lang", language.rawValue)
                    }
                    Link("Telegram", target: "https://t.me/lyabowski")
                        .target(.newWindow)
                        .class("cta-button", "cta-secondary")
                    Link("Email", target: "mailto:aolyakhevich@icloud.com")
                        .class("cta-button", "cta-ghost")
                }
                .class("hero-actions")

                LocalizedTextBlock("p", content: SiteContent.profile.location, classNames: ["hero-meta"])
            }
            .class("hero-copy-column")

            Tag("div") {
                Tag("div") {
                    Tag("img")
                        .attribute("src", SitePaths.avatar)
                        .attribute("alt", "Portrait of Alexander Lyakhevich")
                        .class("hero-photo")
                }
                .class("hero-photo-shell")

                Tag("div") {
                    Tag("div") {
                        LocalizedTextBlock("span", content: .init(ru: "Опыт", en: "Experience"), classNames: ["stat-label"])
                        Tag("strong") { "4+ years" }
                            .class("stat-value")
                    }
                    .class("stat-card")
                    Tag("div") {
                        LocalizedTextBlock("span", content: .init(ru: "Фокус", en: "Focus"), classNames: ["stat-label"])
                        Tag("strong") { "SwiftUI + UIKit" }
                            .class("stat-value")
                    }
                    .class("stat-card")
                    Tag("div") {
                        LocalizedTextBlock("span", content: .init(ru: "Деплой", en: "Delivery"), classNames: ["stat-label"])
                        Tag("strong") { "App Store / CI / Testing" }
                            .class("stat-value")
                    }
                    .class("stat-card")
                }
                .class("hero-stats")
            }
            .class("hero-visual-column")
        }
        .class("hero-section")
        .attribute("id", "top")
    }
}

struct ProjectCardView: HTML {
    let project: ProjectCard

    var body: some HTML {
        Tag("article") {
            Tag("div") {
                Tag("span") { project.period }
                    .class("card-period")
                LocalizedTextBlock("p", content: project.subtitle, classNames: ["card-kicker"])
            }
            .class("card-top")

            Tag("h3") { project.title }
                .class("card-title")

            LocalizedVariantTextBlock("p", content: project.summary, classNames: ["card-summary"])
            LocalizedVariantListBlock(items: project.bullets, classNames: ["card-points"])

            Tag("div") {
                ForEach(project.stack) { item in
                    Tag("span") { item }
                        .class("tech-pill")
                }
            }
            .class("tech-pills")

            if let linkLabel = project.linkLabel, let linkURL = project.linkURL {
                ForEach(CVLanguage.allCases) { language in
                    Link(linkLabel.value(for: language), target: linkURL)
                        .target(.newWindow)
                        .class("card-link")
                        .attribute("data-lang", language.rawValue)
                }
            }
        }
        .class("project-card")
    }
}

struct SelectedWorkSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                LocalizedTextBlock("span", content: .init(ru: "Кейсы", en: "Selected work"), classNames: ["section-eyebrow"])
                LocalizedTextBlock(
                    "h2",
                    content: .init(
                        ru: "Продукты, где я отвечал за структуру, стабильность и скорость поставки.",
                        en: "Products where I owned structure, stability, and shipping velocity."
                    ),
                    classNames: ["section-title"]
                )
            }
            .class("section-heading")

            Tag("div") {
                ForEach(SiteContent.projects) { project in
                    ProjectCardView(project: project)
                }
            }
            .class("project-grid")
        }
        .class("content-section")
        .attribute("id", "work")
    }
}

struct ExperienceEntryView: HTML {
    let entry: ExperienceEntry

    var body: some HTML {
        Tag("article") {
            Tag("div") {
                Tag("span") { entry.period }
                    .class("timeline-period")
                Tag("h3") { entry.company }
                    .class("timeline-title")
                LocalizedTextBlock("p", content: entry.role, classNames: ["timeline-role"])
            }
            .class("timeline-header")

            LocalizedVariantTextBlock("p", content: entry.overview, classNames: ["timeline-summary"])
            LocalizedVariantListBlock(items: entry.highlights, classNames: ["timeline-list"])

            if let linkLabel = entry.linkLabel, let linkURL = entry.linkURL {
                ForEach(CVLanguage.allCases) { language in
                    Link(linkLabel.value(for: language), target: linkURL)
                        .target(.newWindow)
                        .class("timeline-link")
                        .attribute("data-lang", language.rawValue)
                }
            }
        }
        .class("timeline-item")
    }
}

struct ExperienceTimelineSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                LocalizedTextBlock("span", content: .init(ru: "Опыт", en: "Experience"), classNames: ["section-eyebrow"])
                LocalizedTextBlock(
                    "h2",
                    content: .init(
                        ru: "От greenfield-продуктов до migration-heavy команд с живым production.",
                        en: "From greenfield products to migration-heavy teams running live production."
                    ),
                    classNames: ["section-title"]
                )
            }
            .class("section-heading")

            Tag("div") {
                ForEach(SiteContent.experience) { entry in
                    ExperienceEntryView(entry: entry)
                }
            }
            .class("timeline")
        }
        .class("content-section")
        .attribute("id", "experience")
    }
}

struct StackSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                LocalizedTextBlock("span", content: .init(ru: "Стек", en: "Capabilities"), classNames: ["section-eyebrow"])
                LocalizedTextBlock(
                    "h2",
                    content: .init(
                        ru: "Инженерный стек без декоративного шума.",
                        en: "Engineering depth without decorative fluff."
                    ),
                    classNames: ["section-title"]
                )
            }
            .class("section-heading")

            Tag("div") {
                ForEach(SiteContent.skills) { group in
                    Tag("article") {
                        LocalizedTextBlock("h3", content: group.title, classNames: ["stack-card-title"])
                        Tag("div") {
                            ForEach(group.items) { item in
                                Tag("span") { item }
                                    .class("skill-chip")
                            }
                        }
                        .class("skill-cloud")
                    }
                    .class("stack-card")
                }
            }
            .class("stack-grid")
        }
        .class("content-section")
        .attribute("id", "stack")
    }
}

struct EducationSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                LocalizedTextBlock("span", content: .init(ru: "Образование", en: "Education"), classNames: ["section-eyebrow"])
                LocalizedTextBlock(
                    "h2",
                    content: .init(
                        ru: "Курсы и практики, которые усилили архитектурное мышление.",
                        en: "Courses and hands-on programs that sharpened architectural thinking."
                    ),
                    classNames: ["section-title"]
                )
            }
            .class("section-heading")

            Tag("div") {
                ForEach(SiteContent.education) { item in
                    Tag("article") {
                        LocalizedTextBlock("h3", content: item.title, classNames: ["education-title"])
                        LocalizedTextBlock("p", content: item.note, classNames: ["education-note"])
                    }
                    .class("education-card")
                }
            }
            .class("education-grid")
        }
        .class("content-section")
    }
}

struct ContactSection: HTML {
    var body: some HTML {
        Tag("section") {
            Tag("div") {
                LocalizedTextBlock("span", content: .init(ru: "Контакты", en: "Contacts"), classNames: ["section-eyebrow"])
                LocalizedTextBlock(
                    "h2",
                    content: .init(
                        ru: "Можно звать в продукт, где важны архитектура, скорость и аккуратная реализация.",
                        en: "Invite me into products where architecture, velocity, and careful execution matter."
                    ),
                    classNames: ["section-title"]
                )
                LocalizedTextBlock("p", content: SiteContent.profile.statement, classNames: ["contact-copy"])
            }
            .class("section-heading")

            Tag("div") {
                ForEach(SiteContent.contacts) { item in
                    Tag("div") {
                        LocalizedTextBlock("span", content: item.label, classNames: ["contact-label"])
                        if let href = item.href {
                            if href.hasPrefix("http") {
                                Link(item.value, target: href)
                                    .target(.newWindow)
                                    .class("contact-value")
                            } else {
                                Link(item.value, target: href)
                                    .class("contact-value")
                            }
                            } else {
                            Tag("strong") { item.value }
                                .class("contact-value", "plain")
                        }
                    }
                    .class("contact-row")
                }
            }
            .class("contact-grid")
        }
        .class("contact-section")
        .attribute("id", "contact")
    }
}

struct ResumeSidebar: HTML {
    var body: some HTML {
        Tag("aside") {
            Tag("section") {
                Tag("img")
                    .attribute("src", SitePaths.avatar)
                    .attribute("alt", "Portrait of Alexander Lyakhevich")
                    .class("resume-photo")

                Tag("div") {
                    LocalizedTextBlock("h1", content: SiteContent.profile.name, classNames: ["resume-name"])
                    LocalizedTextBlock("p", content: SiteContent.profile.role, classNames: ["resume-role"])
                    LocalizedVariantTextBlock("p", content: SiteContent.profile.intro, classNames: ["resume-summary"])
                }
                .class("resume-intro-copy")
            }
            .class("resume-panel", "resume-intro-panel")

            Tag("section") {
                LocalizedTextBlock("h2", content: .init(ru: "Контакты", en: "Contacts"), classNames: ["resume-section-title"])
                Tag("div") {
                    ForEach(SiteContent.contacts) { item in
                        Tag("div") {
                            LocalizedTextBlock("span", content: item.label, classNames: ["resume-contact-label"])
                            if let href = item.href {
                                if href.hasPrefix("http") {
                                    Link(item.value, target: href)
                                        .target(.newWindow)
                                        .class("resume-contact-value")
                                } else {
                                    Link(item.value, target: href)
                                        .class("resume-contact-value")
                                }
                            } else {
                                Tag("strong") { item.value }
                                    .class("resume-contact-value")
                            }
                        }
                        .class("resume-contact-row")
                    }
                }
                .class("resume-contact-list")
            }
            .class("resume-panel")

            Tag("section") {
                LocalizedTextBlock("h2", content: .init(ru: "Навыки", en: "Skills"), classNames: ["resume-section-title"])
                ForEach(SiteContent.skills) { group in
                    Tag("article") {
                        LocalizedTextBlock("h3", content: group.title, classNames: ["resume-skill-group"])
                        Tag("p") {
                            group.items.joined(separator: " · ")
                        }
                        .class("resume-skill-copy")
                    }
                    .class("resume-skill-card")
                }
            }
            .class("resume-panel")

            Tag("section") {
                LocalizedTextBlock("h2", content: .init(ru: "Образование", en: "Education"), classNames: ["resume-section-title"])
                ForEach(SiteContent.education) { item in
                    Tag("article") {
                        LocalizedTextBlock("h3", content: item.title, classNames: ["resume-education-title"])
                        LocalizedTextBlock("p", content: item.note, classNames: ["resume-education-note"])
                    }
                    .class("resume-education-card")
                }
            }
            .class("resume-panel")
        }
        .class("resume-sidebar")
    }
}

struct ResumeMainColumn: HTML {
    var body: some HTML {
        Tag("div") {
            Tag("section") {
                LocalizedTextBlock("h2", content: .init(ru: "Опыт", en: "Experience"), classNames: ["resume-section-title"])
                ForEach(SiteContent.experience) { entry in
                    Tag("article") {
                        Tag("div") {
                            Tag("div") {
                                Tag("h3") { entry.company }
                                    .class("resume-entry-title")
                                LocalizedTextBlock("p", content: entry.role, classNames: ["resume-entry-role"])
                            }
                            Tag("span") { entry.period }
                                .class("resume-entry-period")
                        }
                        .class("resume-entry-header")

                        LocalizedVariantTextBlock("p", content: entry.overview, classNames: ["resume-entry-summary"])
                        LocalizedVariantListBlock(items: entry.highlights, classNames: ["resume-entry-list"])
                    }
                    .class("resume-entry")
                }
            }
            .class("resume-panel")

            Tag("section") {
                LocalizedTextBlock("h2", content: .init(ru: "Selected work", en: "Selected work"), classNames: ["resume-section-title"])
                ForEach(SiteContent.projects) { project in
                    Tag("article") {
                        Tag("div") {
                            Tag("h3") { project.title }
                                .class("resume-entry-title")
                            Tag("span") { project.period }
                                .class("resume-entry-period")
                        }
                        .class("resume-entry-header")

                        LocalizedTextBlock("p", content: project.subtitle, classNames: ["resume-entry-role"])
                        LocalizedVariantTextBlock("p", content: project.summary, classNames: ["resume-entry-summary"])
                        LocalizedVariantListBlock(items: project.bullets, classNames: ["resume-entry-list"])
                    }
                    .class("resume-entry")
                }
            }
            .class("resume-panel")
        }
        .class("resume-main")
    }
}
