import Foundation
import Ignite

struct HomePage: StaticPage {
    var title = "Alexander Lyakhevich"
    var path = "/"
    var description = "Swift-first portfolio for Alexander Lyakhevich, iOS developer."

    var body: some HTML {
        Tag("div") {
            TopBar()
            Tag("div") {
                SectionNavigation()
                Tag("main") {
                    HeroSection()
                    SelectedWorkSection()
                    ExperienceTimelineSection()
                    StackSection()
                    EducationSection()
                    ServicesSection()
                    ContactSection()
                }
                .class("page-stack")
            }
            .class("documentation-layout")
            SiteFooter()
        }
        .class("portfolio-page")
    }
}
