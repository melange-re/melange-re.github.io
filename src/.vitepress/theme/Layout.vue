<script setup lang="ts">
import { useData, useRoute } from "vitepress";
import DefaultTheme from "vitepress/theme";
import { computed } from "vue";
import Switch from "./Switch.vue";
import BlogHome from "./blog/Home.vue";
import BlogArticle from "./blog/Article.vue";
import BlogNotFound from "./blog/NotFound.vue";
import PlaygroundLayout from "./PlaygroundLayout.vue";
import './custom.css'

const { Layout } = DefaultTheme;
const { page, frontmatter } = useData();
const route = useRoute();

// Check if we're on a blog page based on URL path
const isBlogPage = computed(() => {
  const path = route.path;
  return path.includes('/blog/');
});
const isBlogIndex = computed(() => frontmatter.value.index === true);

// Check if we're on the playground page
const isPlaygroundPage = computed(() => {
  const path = route.path;
  return path.includes('/playground');
});
</script>

<template>
  <!-- For playground page, use the playground layout -->
  <PlaygroundLayout v-if="isPlaygroundPage" />

  <!-- For docs pages, use the regular layout with syntax switch -->
  <Layout v-else-if="!isBlogPage">
    <template #sidebar-nav-before>
      <Switch> Hello </Switch>
    </template>
  </Layout>

  <!-- For blog pages, render content after the nav -->
  <Layout v-else class="blog-layout">
    <template #layout-bottom>
      <main class="blog-main">
        <div class="blog-content-area">
          <BlogHome v-if="isBlogIndex" />
          <BlogNotFound v-else-if="page.isNotFound" />
          <BlogArticle v-else />
        </div>
      </main>
    </template>
  </Layout>
</template>

<style>
/* Blog layout styles */
.blog-layout .VPContent {
  display: none !important;
}

.blog-layout .VPSidebar {
  display: none !important;
}

.blog-layout .VPLocalNav {
  display: none !important;
}

.blog-main {
  padding-top: 0;
  min-height: calc(100vh - var(--vp-nav-height));
}

.blog-content-area {
  max-width: 65rem;
  margin: 0 auto;
  padding: 2rem 1.5rem;
}
</style>
