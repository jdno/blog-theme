/*
Toggles between the light and dark color scheme. The effective scheme is
the stored preference if there is one, otherwise the system preference.
The choice is persisted in localStorage and applied before first paint by
an inline script in default.hbs.
*/

export default function themeToggle() {
    const button = document.querySelector(".gh-theme-toggle");

    if (!button) {
        return;
    }

    button.addEventListener("click", () => {
        const stored = localStorage.getItem("theme");
        const systemDark = window.matchMedia(
            "(prefers-color-scheme: dark)",
        ).matches;
        const current = stored || (systemDark ? "dark" : "light");
        const next = current === "dark" ? "light" : "dark";

        localStorage.setItem("theme", next);
        document.documentElement.setAttribute("data-theme", next);
    });
}
