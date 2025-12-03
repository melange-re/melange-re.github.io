<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';
import DefaultTheme from 'vitepress/theme';
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import App from './playground/App.jsx';

const { Layout } = DefaultTheme;

const playgroundContainer = ref<HTMLElement | null>(null);
let root: ReactDOM.Root | null = null;

onMounted(() => {
  if (playgroundContainer.value) {
    root = ReactDOM.createRoot(playgroundContainer.value);
    root.render(React.createElement(App));
  }
});

onUnmounted(() => {
  if (root) {
    root.unmount();
    root = null;
  }
});
</script>

<template>
  <Layout class="playground-layout">
    <template #layout-bottom>
      <div class="playground-container" ref="playgroundContainer"></div>
    </template>
  </Layout>
</template>

<style>
/* Hide VitePress content elements on playground page */
.playground-layout .VPContent {
  display: none !important;
}

.playground-layout .VPSidebar {
  display: none !important;
}

.playground-layout .VPLocalNav {
  display: none !important;
}

.playground-layout .VPFooter {
  display: none !important;
}

.playground-container {
  width: 100%;
  height: calc(100vh - var(--vp-nav-height));
  margin: 0;
  padding: 0;
}

/* Reset box-sizing for playground */
.playground-container,
.playground-container * {
  box-sizing: border-box;
}
</style>
