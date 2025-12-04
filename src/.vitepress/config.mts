import { readFileSync } from "fs";
import { join, resolve } from "path";
import { defineConfig } from "vitepress";
import type { Plugin } from "vite";
import markdownItFootnote from 'markdown-it-footnote'
import { bundledLanguages } from "shiki";
import { genFeed } from './genFeed.js'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// Custom plugin to strip sourcemaps from js_of_ocaml-generated files.
// These files have inline index sourcemaps that Vite's applySourcemapIgnoreList
// function can't handle, causing "Cannot read properties of undefined (reading 'length')" errors.
// We use the `load` hook instead of `transform` because Vite processes sourcemaps
// during the load phase, before transforms run.
function stripJsooSourcemaps(): Plugin {
  return {
    name: 'strip-jsoo-sourcemaps',
    enforce: 'pre',
    load(id) {
      // Only process .bc.js files from the playground build directory
      if (id.includes('_build/default/playground-assets') && id.endsWith('.bc.js')) {
        // Read the file and strip the inline sourcemap
        const code = readFileSync(id, 'utf-8');
        const strippedCode = code.replace(/\/\/# sourceMappingURL=data:[^\n]+/g, '');
        return { code: strippedCode, map: null };
      }
      return null;
    },
  };
}

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

// BASE can be empty string for dev (root path) or a version like "unstable" for prod
const base = process.env.BASE !== undefined ? process.env.BASE : "unstable";

// Resolve paths for dune build outputs (playground assets)
// __dirname is src/.vitepress, so we go up 2 levels to get to the project root
const rootDir = resolve(__dirname, '../..');
const playgroundBuildDir = resolve(rootDir, '_build/default/playground-assets');

// https://vitepress.dev/reference/site-config
export default defineConfig({
  // Some links in the API are death, some of them because of the removal in Makefile "pull-melange-docs"
  // We can't use (_, source) => source.toLowerCase().includes('api') since it comes from vitepress 2, using true (which ignores all deadlinks)
  ignoreDeadLinks: true,
  title: "Melange",
  cleanUrls: true,
  head: [
    [
      'script',
      {},
      toggleSyntaxScript
    ]
  ],
  description:
    "The official documentation site for Melange, a compiler from OCaml to JavaScript. Explore the features and resources for functional programming with Melange, including the standard libraries APIs, the playground, and extensive documentation about bindings, build system, and the opam package manager.",
  base: base ? `/${base}/` : '/',
  sitemap: {
    hostname: base ? `https://melange.re/${base}/` : 'https://melange.re/',
  },
  buildEnd: genFeed,
  markdown: {
    languages: [duneGrammar, ocamlGrammar, opamGrammar, reasonGrammar],
    config: (md) => {
      md.use(markdownItFootnote)
    },
  },
  vite: {
    plugins: [
      stripJsooSourcemaps(),
      tailwindcss(),
      react({
        include: /\.(jsx|tsx)$/,
      }),
    ],
    resolve: {
      alias: {
        '@playground-assets': playgroundBuildDir,
      },
    },
    optimizeDeps: {
      include: ['react', 'react-dom', '@monaco-editor/react']
    },
    build: {
      rollupOptions: {
        // Don't treeshake the dune-generated files as they are side-effect scripts
        treeshake: false,
      },
    },
  },
  themeConfig: {
    outline: { level: [2, 3] },
    search: {
      provider: "local",
    },
    editLink: {
      pattern:
        "https://github.com/melange-re/melange-re.github.io/edit/master/src/:path",
    },
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Learn", link: "/what-is-melange" },
      { text: "API", link: "/api" },
      { text: "Playground", link: "/playground" },
      { text: "Book", link: "https://react-book.melange.re" },
      // Blog: in dev (base='') use relative /blog/, in prod use absolute URL
      { text: "Blog", link: base ? "https://melange.re/blog/" : "/blog/" },
      {
        text: base || "dev",
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
{
        component: 'LanguageToggleWrapper'

}
    ],

    sidebar: {
      // Blog pages have no sidebar
      '/blog/': [],
      // Playground has no sidebar
      '/playground': [],
      // Default sidebar for docs
      '/': [
        {
          text: "Intro",
          items: [
            { text: "What is Melange", link: "/what-is-melange" },
            { text: "Rationale", link: "/rationale" },
            { text: "Supported syntaxes", link: "/syntaxes" },
            { text: "Getting Started", link: "/getting-started" },
          ],
        },
        {
          text: "Learn",
          items: [
            { text: "New to OCaml?", link: "/new-to-ocaml" },
            { text: "Package Management", link: "/package-management" },
            { text: "Build System", link: "/build-system" },
            { text: "How-to Guides", link: "/how-to-guides" },
            {
              text: "Melange for X Developers",
              link: "/melange-for-x-developers",
            },
          ],
        },
        {
          text: 'Communicate with JavaScript',
          items: [
            { text: "Overview", link: "/communicate-with-javascript" },
            { text: "Language concepts", link: "/language-concepts" },
            { text: "Data types and runtime representation", link: "/data-types-and-runtime-rep" },
            { text: "Melange attributes and extension nodes", link: "/attributes-and-extension-nodes" },
            { text: "Working with JavaScript objects and values", link: "/working-with-js-objects-and-values" },
            { text: "Advanced JavaScript interoperability", link: "/advanced-js-interop" },
            { text: "Bindings cookbook", link: "/bindings-cookbook" },
          ],
        },
        {
          text: "Reference",
          items: [{ text: "API", link: "/api" }],
        },
        {
          text: "Try",
          items: [{ text: "Playground", link: "/playground" }],
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
    },

    socialLinks: [
      { icon: "github", link: "https://github.com/melange-re/melange" },
    ],
  },
});
