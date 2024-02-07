import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Melange Documentation Site",
  description: "The official documentation site for Melange, a compiler from OCaml to JavaScript. Explore the features and resources for functional programming with Melange, including the standard libraries APIs, the playground, and extensive documentation about bindings, build system, and the opam package manager.",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Learn', link: '/what-is-melange' },
      { text: 'API', link: '/api' },
      { text: 'Playground', link: '/playground' },
    ],

    sidebar: [
      {
        text: 'Intro',
        items: [
          { text: 'What is Melange', link: '/what-is-melange' },
          { text: 'Why', link: '/rationale' },
          { text: 'Getting Started', link: '/getting-started' }
        ]
      },{
        text: 'Learn',
        items: [
          { text: 'New to OCaml?', link: '/new-to-ocaml' },
          { text: 'Package Management', link: '/package-management' },
          { text: 'Build System', link: '/build-system' },
          { text: 'Communicate with JavaScript', link: '/communicate-with-javascript' },
          { text: 'How-to Guides', link: '/how-to-guides' },
          { text: 'Melange for X Developers', link: '/melange-for-x-developers' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/melange-re/melange' }
    ]
  }
})
