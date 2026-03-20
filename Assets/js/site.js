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
      localStorage.setItem("cv-lang", value);
      updatePressed(value);
      updateToggleCopy();
    }

    const lang = localStorage.getItem("cv-lang") || body.dataset.lang || "ru";
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
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init, { once: true });
  } else {
    init();
  }
})();
