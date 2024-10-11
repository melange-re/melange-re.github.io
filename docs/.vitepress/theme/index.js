// You can directly import Vue files in the theme entry
// VitePress is pre-configured with @vitejs/plugin-vue.
import Layout from './Layout.vue'
import Users from './Users.vue'

export default {
  Layout,
  enhanceApp({ app  }) {
    app.component('Users', Users)
  }
}
