import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        let siteScript = (try? String(contentsOfFile: "Assets/js/site.js")) ?? ""

        PlainDocument {
            Head {
                MetaTag(name: "theme-color", content: "#f3ede3")
                MetaTag(.openGraphImage, content: SitePaths.siteURL + "images/avatar.jpg")
                MetaTag(.twitterImage, content: SitePaths.siteURL + "images/avatar.jpg")
                MetaTag(name: "twitter:creator", content: "@lyabowski")
                MetaLink(href: SitePaths.favicon, rel: .icon)
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
            .customAttribute(name: "lang", value: "ru")
        }
    }
}
