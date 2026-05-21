import Foundation
import Ignite

struct HomePage: StaticPage {
    var title = "Alexander Lyakhevich"
    var path = "/"
    var description = "Swift-first portfolio for Alexander Lyakhevich, iOS developer."

    var body: some HTML {
        Tag("div") {
            TopBar()
            Tag("main") {
                HeroSection()
                ServicesSection()
                SelectedWorkSection()
                ExperienceTimelineSection()
                StackSection()
                EducationSection()
                ContactSection()
            }
            .class("page-stack")
        }
        .class("portfolio-page")
    }
}
