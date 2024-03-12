import { readFileSync } from "fs";
import { join } from "path";
import { defineConfig } from "vitepress";

const toggleSyntaxScript = readFileSync(join(__dirname, './toggleSyntax.js'), 'utf8');

// From https://github.com/ocamllabs/vscode-ocaml-platform/blob/master/syntaxes/reason.json
const reasonGrammar = JSON.parse(
  readFileSync(join(__dirname, "./reasonml.tmLanguage.json"), "utf8")
);

const base = process.env.BASE || "unstable";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Melange Documentation Site",
  head:[
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
    languages: [reasonGrammar],
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
          { text: "Roadmap", link: "/roadmap" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/melange-re/melange" },
    ],
  },
});
