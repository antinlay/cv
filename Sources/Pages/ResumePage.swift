import Foundation
import Ignite

struct ResumePage: StaticPage {
    var title = "Resume"
    var path = "/resume/"
    var description = "Print-friendly bilingual resume for Alexander Lyakhevich."

    var body: some HTML {
        Tag("div") {
            ResumeToolbar()
            Tag("main") {
                ResumeSidebar()
                ResumeMainColumn()
            }
            .class("resume-layout")
        }
        .class("resume-page")
    }
}
