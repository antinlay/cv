import Foundation
import Ignite

@main
struct CVWebsite {
    static func main() async {
        var site = PortfolioSite()

        do {
            try await site.publish()
            try postProcessBuild()
        } catch {
            print(error.localizedDescription)
        }
    }

    private static func postProcessBuild() throws {
        let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let buildDirectory = root.appending(path: "Build")
        let htmlFiles = try FileManager.default.contentsOfDirectory(
            at: buildDirectory,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ).flatMap { url -> [URL] in
            if url.pathExtension == "html" {
                return [url]
            }

            guard
                let enumerator = FileManager.default.enumerator(
                    at: url,
                    includingPropertiesForKeys: nil,
                    options: [.skipsHiddenFiles]
                )
            else {
                return []
            }

            return enumerator.compactMap { $0 as? URL }.filter { $0.pathExtension == "html" }
        }

        for fileURL in htmlFiles {
            let original = try String(contentsOf: fileURL)
            let updated = original.replacingOccurrences(
                of: "src=\"/js/ignite-core.js\"",
                with: "src=\"\(SitePaths.base)/js/ignite-core.js\""
            )

            if updated != original {
                try updated.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        }
    }
}

struct PortfolioSite: Site {
    var name = "Alexander Lyakhevich"
    var titleSuffix = " - iOS Architecture & SwiftUI Audit"
    var description = "iOS architecture and SwiftUI audit consulting for startups and mobile teams: repo review, risk report, performance fixes, and Codex-ready fix plans."
    var language: Language = .russian
    var url = URL(static: "https://antinlay.github.io/cv/")
    var useDefaultBootstrapURLs: BootstrapOptions = .none
    var builtInIconsEnabled: BootstrapOptions = .none
    var homePage = HomePage()
    var layout = MainLayout()

    var staticPages: [any StaticPage] {
        ResumePage()
    }
}
