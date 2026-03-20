import Foundation
import Ignite

struct LanguageToggle: HTML {
    let className: String

    init(className: String = "state-group") {
        self.className = className
    }

    var body: some HTML {
        Tag("div") {
            ToggleButton(
                set: "lang",
                value: "ru",
                defaultLabel: "RU"
            )
            ToggleButton(
                set: "lang",
                value: "en",
                defaultLabel: "EN"
            )
        }
        .class(className)
        .attribute("role", "group")
        .attribute("aria-label", "Language")
    }
}

struct LengthToggle: HTML {
    let className: String

    init(className: String = "state-group") {
        self.className = className
    }

    var body: some HTML {
        Tag("div") {
            ToggleButton(
                set: "length",
                value: "short",
                defaultLabel: "Коротко",
                ruLabel: "Коротко",
                enLabel: "Short"
            )
            ToggleButton(
                set: "length",
                value: "full",
                defaultLabel: "Полно",
                ruLabel: "Полно",
                enLabel: "Full"
            )
        }
        .class(className)
        .attribute("role", "group")
        .attribute("aria-label", "Length")
    }
}

struct ResumeToolbar: HTML {
    var body: some HTML {
        Tag("div") {
            LengthToggle()
            Tag("div").class("toolbar-divider")
            Tag("button") {
                "В PDF"
            }
            .attribute("type", "button")
            .attribute("id", "save-pdf")
            .attribute("data-text-ru", "В PDF")
            .attribute("data-text-en", "Export PDF")
            .class("state-button", "toolbar-action")
            Tag("div").class("toolbar-divider")
            LanguageToggle()
        }
        .class("resume-toolbar")
    }
}

struct ToggleButton: HTML {
    let set: String
    let value: String
    let defaultLabel: String
    let ruLabel: String?
    let enLabel: String?

    init(
        set: String,
        value: String,
        defaultLabel: String,
        ruLabel: String? = nil,
        enLabel: String? = nil
    ) {
        self.set = set
        self.value = value
        self.defaultLabel = defaultLabel
        self.ruLabel = ruLabel
        self.enLabel = enLabel
    }

    var body: some HTML {
        Tag("button") {
            defaultLabel
        }
        .attribute("type", "button")
        .attribute("data-set", set)
        .attribute("data-value", value)
        .attribute("aria-pressed", "false")
        .attribute("data-label-ru", ruLabel ?? defaultLabel)
        .attribute("data-label-en", enLabel ?? defaultLabel)
        .class("state-button")
    }
}
