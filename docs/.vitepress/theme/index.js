// You can directly import Vue files in the theme entry
// VitePress is pre-configured with @vitejs/plugin-vue.
import Layout from './Layout.vue'
import './blog/style.css'

export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    // ...
  }
}
