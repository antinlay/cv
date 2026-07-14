(function () {
  function init() {
    const body = document.body;
    if (!body) return;

    const validLanguages = new Set(["ru", "en"]);

    function updatePressed(value) {
      document.querySelectorAll('[data-set="lang"]').forEach((button) => {
        button.setAttribute("aria-pressed", button.dataset.value === value ? "true" : "false");
      });
    }

    function updateToggleCopy() {
      const lang = body.dataset.lang || "ru";
      document.querySelectorAll("[data-label-ru]").forEach((button) => {
        button.textContent = lang === "en" ? button.dataset.labelEn : button.dataset.labelRu;
      });
      document.querySelectorAll("[data-text-ru]").forEach((button) => {
        button.textContent = lang === "en" ? button.dataset.textEn : button.dataset.textRu;
      });
    }

    function setLanguage(value) {
      if (!validLanguages.has(value)) return;
      body.dataset.lang = value;
      document.documentElement.lang = value;
      try {
        localStorage.setItem("cv-lang", value);
      } catch (_) {
        // Private browsing or disabled storage should not block the page.
      }
      updatePressed(value);
      updateToggleCopy();
    }

    let savedLanguage = null;
    try {
      savedLanguage = localStorage.getItem("cv-lang");
    } catch (_) {
      savedLanguage = null;
    }

    const lang = savedLanguage || body.dataset.lang || "ru";
    setLanguage(validLanguages.has(lang) ? lang : "ru");

    document.querySelectorAll('[data-set="lang"]').forEach((button) => {
      button.addEventListener("click", () => {
        setLanguage(button.dataset.value);
      });
    });

    const saveButton = document.getElementById("save-pdf");
    if (saveButton) {
      saveButton.addEventListener("click", () => {
        window.print();
      });
    }

    const sections = [...document.querySelectorAll("main [id]")];
    const navigationLinks = [...document.querySelectorAll(".top-link[href^='#']")];

    function updateActiveSection(id) {
      navigationLinks.forEach((link) => {
        const isActive = link.getAttribute("href") === `#${id}`;
        link.classList.toggle("is-active", isActive);
        if (isActive) {
          link.setAttribute("aria-current", "location");
        } else {
          link.removeAttribute("aria-current");
        }
      });
    }

    if ("IntersectionObserver" in window && sections.length > 0) {
      const observer = new IntersectionObserver(
        (entries) => {
          const visibleEntry = entries
            .filter((entry) => entry.isIntersecting)
            .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];

          if (visibleEntry) updateActiveSection(visibleEntry.target.id);
        },
        { rootMargin: "-18% 0px -68% 0px", threshold: [0, 0.25, 0.6] }
      );

      sections.forEach((section) => observer.observe(section));
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init, { once: true });
  } else {
    init();
  }
})();
