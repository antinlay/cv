(function () {
  const body = document.body;
  if (!body) return;

  const valid = {
    lang: new Set(["ru", "en"]),
    length: new Set(["short", "full"])
  };

  function updatePressed(attr, value) {
    document.querySelectorAll(`[data-set="${attr}"]`).forEach((button) => {
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

  function setState(attr, value) {
    if (!valid[attr] || !valid[attr].has(value)) return;
    body.dataset[attr] = value;
    localStorage.setItem(`cv-${attr}`, value);
    updatePressed(attr, value);
    if (attr === "lang") updateToggleCopy();
  }

  function restoreState() {
    const lang = localStorage.getItem("cv-lang") || body.dataset.lang || "ru";
    const length = localStorage.getItem("cv-length") || body.dataset.length || "full";
    setState("lang", valid.lang.has(lang) ? lang : "ru");
    setState("length", valid.length.has(length) ? length : "full");
    updateToggleCopy();
    body.dataset.ready = "true";
  }

  document.querySelectorAll("[data-set]").forEach((button) => {
    button.addEventListener("click", () => {
      setState(button.dataset.set, button.dataset.value);
    });
  });

  const saveButton = document.getElementById("save-pdf");
  if (saveButton) {
    saveButton.addEventListener("click", () => {
      window.print();
    });
  }

  restoreState();
})();
