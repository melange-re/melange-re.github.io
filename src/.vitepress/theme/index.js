import Layout from './Layout.vue'
import LanguageToggleWrapper from './LanguageToggleWrapper.vue'
import PlaygroundLayout from './PlaygroundLayout.vue'
import './blog/style.css'

export default {
  Layout,
  enhanceApp({ app, router, siteData }) {
    app.component('LanguageToggleWrapper', LanguageToggleWrapper)
    app.component('PlaygroundLayout', PlaygroundLayout)
  }
}
