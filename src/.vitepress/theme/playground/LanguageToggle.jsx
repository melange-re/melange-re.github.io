import * as React from "react";

export const languageMap = {
  Reason: "Reason",
  OCaml: "OCaml",
};

const SYNTAX_CLASS_PREFIX = "syntax__";
const languageToSyntaxClass = {
  [languageMap.Reason]: "reasonml",
  [languageMap.OCaml]: "ocaml",
};

function OCamlLogo() {
  return (
    <svg
      className="OCamlLogo"
      width="14"
      height="14"
      viewBox="0 0 14 14"
      xmlns="http://www.w3.org/2000/svg"
    >
      <rect width="14" height="14" rx="2" />
    </svg>
  );
}

function ReasonLogo() {
  return (
    <svg
      className="ReasonLogo"
      width="14"
      height="14"
      viewBox="0 0 14 14"
      xmlns="http://www.w3.org/2000/svg"
    >
      <rect width="14" height="14" rx="2" />
    </svg>
  );
}

const classNames = (...classes) =>
  classes
    .reduce(
      (className, current) =>
        className.concat(
          typeof current == "string"
            ? current
            : Array.isArray(current)
              ? classNames(...current)
              : typeof current == "object" && current
                ? Object.keys(current).map((key) => (current[key] ? key : ""))
                : ""
        ),
      []
    )
    .join(" ");

function LanguageToggle({ language, onChange }) {
  React.useEffect(() => {
    const syntaxClass = languageToSyntaxClass[language];
    if (!syntaxClass) return;

    Object.values(languageToSyntaxClass).forEach((cls) => {
      document.body.classList.remove(`${SYNTAX_CLASS_PREFIX}${cls}`);
    });

    document.body.classList.add(`${SYNTAX_CLASS_PREFIX}${syntaxClass}`);

    localStorage.setItem("syntax", syntaxClass);
  }, [language]);

  return (
    <div className="Tabs">
      <button
        className={classNames([
          "IconButton",
          language === languageMap.OCaml ? "active" : "",
        ])}
        onClick={() => onChange(languageMap.OCaml)}
      >
        <OCamlLogo />
        OCaml
      </button>
      <button
        className={classNames([
          "IconButton",
          language === languageMap.Reason ? "active" : "",
        ])}
        onClick={() => onChange(languageMap.Reason)}
      >
        <ReasonLogo />
        Reason
      </button>
    </div>
  );
}

export default LanguageToggle;

