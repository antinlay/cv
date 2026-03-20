import Foundation
import Ignite

struct LocalizedTextBlock: HTML {
    let tag: String
    let content: Localized<String>
    let classNames: [String]

    init(_ tag: String, content: Localized<String>, classNames: [String] = []) {
        self.tag = tag
        self.content = content
        self.classNames = classNames
    }

    var body: some HTML {
        ForEach(CVLanguage.allCases) { language in
            Tag(tag) {
                content.value(for: language)
            }
            .attribute("data-lang", language.rawValue)
            .class(classNames)
        }
    }
}

struct LocalizedVariantTextBlock: HTML {
    let tag: String
    let content: Localized<Variant<String>>
    let classNames: [String]

    init(_ tag: String, content: Localized<Variant<String>>, classNames: [String] = []) {
        self.tag = tag
        self.content = content
        self.classNames = classNames
    }

    var body: some HTML {
        ForEach(CVLanguage.allCases) { language in
            ForEach(CVLength.allCases) { length in
                Tag(tag) {
                    content.value(for: language).value(for: length)
                }
                .attribute("data-lang", language.rawValue)
                .attribute("data-length", length.rawValue)
                .class(classNames)
            }
        }
    }
}

struct LocalizedListBlock: HTML {
    let items: Localized<[String]>
    let classNames: [String]

    init(items: Localized<[String]>, classNames: [String] = []) {
        self.items = items
        self.classNames = classNames
    }

    var body: some HTML {
        ForEach(CVLanguage.allCases) { language in
            Tag("ul") {
                ForEach(items.value(for: language)) { item in
                    Tag("li") {
                        item
                    }
                }
            }
            .attribute("data-lang", language.rawValue)
            .class(classNames)
        }
    }
}

struct LocalizedVariantListBlock: HTML {
    let items: Localized<Variant<[String]>>
    let classNames: [String]

    init(items: Localized<Variant<[String]>>, classNames: [String] = []) {
        self.items = items
        self.classNames = classNames
    }

    var body: some HTML {
        ForEach(CVLanguage.allCases) { language in
            ForEach(CVLength.allCases) { length in
                Tag("ul") {
                    ForEach(items.value(for: language).value(for: length)) { item in
                        Tag("li") {
                            item
                        }
                    }
                }
                .attribute("data-lang", language.rawValue)
                .attribute("data-length", length.rawValue)
                .class(classNames)
            }
        }
    }
}
