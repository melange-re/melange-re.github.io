// Keep in sync with Switch.vue
// Just needed so that Vitepress finds the content already in the right
// position when it scrolls to location hash
document.addEventListener("DOMContentLoaded", () => {
    const SYNTAXES = ["reasonml", "ocaml"];
    const CLASS_PREFIX = "syntax__";
    let currentSyntax;
    let setCurrentSyntax = (syntax = SYNTAXES[0]) => {
        document.body.classList.remove(`${CLASS_PREFIX}${currentSyntax}`);
        document.body.classList.add(`${CLASS_PREFIX}${syntax}`);

        currentSyntax = syntax;
        localStorage.setItem("syntax", currentSyntax);
    };

    setCurrentSyntax(
        localStorage.getItem("syntax", currentSyntax) || SYNTAXES[0]
    );
});
