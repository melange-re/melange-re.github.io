import { readFileSync } from "fs";
import { join } from "path";
import { defineConfig } from "vitepress";
import { bundledLanguages } from "shiki";

// Modify bundledLanguages so it no longer contains the bundled OCaml grammar. This is needed because vitepress config
// doesn't allow you to override bundled grammars, see
// https://github.com/vuejs/vitepress/blob/78c4d3dda085f31912578237dfbe7b1c62f48859/src/node/markdown/plugins/highlight.ts#L65
delete bundledLanguages['ocaml'];

const toggleSyntaxScript = readFileSync(join(__dirname, './toggleSyntax.js'), 'utf8');

// From https://github.com/ocamllabs/vscode-ocaml-platform/blob/master/syntaxes/reason.json
const reasonGrammar = JSON.parse(
  readFileSync(join(__dirname, "./reasonml.tmLanguage.json"), "utf8")
);

// From https://github.com/ocamllabs/vscode-ocaml-platform/blob/master/syntaxes/dune.json
const duneGrammar = JSON.parse(
  readFileSync(join(__dirname, "./dune.tmLanguage.json"), "utf8")
);

// From https://github.com/ocamllabs/vscode-ocaml-platform/blob/master/syntaxes/opam.json
const opamGrammar = JSON.parse(
  readFileSync(join(__dirname, "./opam.tmLanguage.json"), "utf8")
);

// From https://github.com/ocamllabs/vscode-ocaml-platform/blob/master/syntaxes/ocaml.json
const ocamlGrammar = JSON.parse(
  readFileSync(join(__dirname, "./ocaml.tmLanguage.json"), "utf8")
);

const base = process.env.BASE || "unstable";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Melange Documentation Site",
  head: [
    [
      'script',
      {},
      toggleSyntaxScript
    ]
  ],
  description:
    "The official documentation site for Melange, a compiler from OCaml to JavaScript. Explore the features and resources for functional programming with Melange, including the standard libraries APIs, the playground, and extensive documentation about bindings, build system, and the opam package manager.",
  base: `/${base}/`,
  sitemap: {
    hostname: `https://melange.re/${base}/`,
  },
  markdown: {
    languages: [duneGrammar, ocamlGrammar, opamGrammar, reasonGrammar],
    shikiSetup: highlighter => {
      highlighter.loadLanguage(ocamlGrammar);
    }
  },
  themeConfig: {
    outline: { level: [2, 3] },
    search: {
      provider: "local",
    },
    editLink: {
      pattern:
        "https://github.com/melange-re/melange-re.github.io/edit/master/docs/:path",
    },
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Learn", link: "/what-is-melange" },
      { text: "API", link: "/api" },
      { text: "Playground", link: "/playground/", target: "_self" },
      { text: "Blog", link: "https://melange.re/blog" },
      {
        text: "unstable",
        items: [
          {
            text: "v4.0.0",
            link: "https://melange.re/v4.0.0/",
          },
          {
            text: "v3.0.0",
            link: "https://melange.re/v3.0.0/",
          },
          {
            text: "v2.2.0",
            link: "https://melange.re/v2.2.0/",
          },
          {
            text: "v2.1.0",
            link: "https://melange.re/v2.1.0/",
          },
          {
            text: "v2.0.0",
            link: "https://melange.re/v2.0.0/",
          },
          {
            text: "v1.0.0",
            link: "https://melange.re/v1.0.0/",
          },
        ],
      },
    ],

    sidebar: [
      {
        text: "Intro",
        items: [
          { text: "What is Melange", link: "/what-is-melange" },
          { text: "Rationale", link: "/rationale" },
          { text: "Getting Started", link: "/getting-started" },
        ],
      },
      {
        text: "Learn",
        items: [
          { text: "New to OCaml?", link: "/new-to-ocaml" },
          { text: "Package Management", link: "/package-management" },
          { text: "Build System", link: "/build-system" },
          {
            text: "Communicate with JavaScript",
            link: "/communicate-with-javascript",
          },
          { text: "How-to Guides", link: "/how-to-guides" },
          {
            text: "Melange for X Developers",
            link: "/melange-for-x-developers",
          },
        ],
      },
      {
        text: "Language Basics",
        items: [
          { text: "Overview", link: "/overview" },
          { text: "Let bindings", link: "/let-bindings" },
          { text: "Primitives", link: "/primitives" },
          { text: "Basic structures", link: "/basic-structures" },
          { text: "Types", link: "/types" },
          { text: "Records", link: "/records" },
          { text: "Variants", link: "/variants" },
          { text: "Options and nullability", link: "/options" },
          { text: "Functions", link: "/functions" },
          { text: "Recursion", link: "/recursion" },
          { text: "Destructuring", link: "/destructuring" },
          { text: "Pattern matching", link: "/pattern-matching" },
          { text: "Mutable bindings", link: "/mutable-bindings" },
          { text: "Loops", link: "/loops" },
          { text: "Module", link: "/module" },
        ],
      },
      {
        text: "Reference",
        items: [{ text: "API", link: "/api" }],
      },
      {
        text: "Try",
        items: [{ text: "Playground", link: "/playground/", target: "_self" }],
      },
      {
        text: "About",
        items: [
          { text: "Community", link: "/community" },
          { text: "Resources", link: "/resources" },
          { text: "Roadmap", link: "/roadmap" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/melange-re/melange" },
    ],
  },
});
