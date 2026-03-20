import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        let siteScript = (try? String(contentsOfFile: "Assets/js/site.js")) ?? ""

        PlainDocument {
            Head {
                MetaTag(name: "theme-color", content: "#f3ede3")
                MetaLink(href: "/css/site.css", rel: .stylesheet)
                if siteScript.isEmpty == false {
                    Script(code: siteScript)
                }
            }
            Body {
                content
            }
            .ignorePageGutters()
            .data("lang", "ru")
            .customAttribute(name: "class", value: "cv-body")
        }
    }
}
