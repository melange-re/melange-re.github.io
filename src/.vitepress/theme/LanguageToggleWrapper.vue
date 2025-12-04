<template>
  <div class="language-toggle-wrapper">
    <div class="separator"></div>
    <div ref="container" class="language-toggle-container"></div>
  </div>
</template>

<script>
import { onMounted, onUnmounted, ref } from "vue";
import * as React from "react";
import { createRoot } from "react-dom/client";
import LanguageToggle, {
  languageMap,
} from "./playground/LanguageToggle.jsx";

export default {
  setup() {
    const container = ref(null);
    let root = null;

    onMounted(() => {
      if (container.value) {
        root = createRoot(container.value);

        // Read the initial language from localStorage
        const storedSyntax = localStorage.getItem("syntax");
        const initialLanguage =
          storedSyntax === "reasonml" ? languageMap.Reason : languageMap.OCaml;

        const render = (language) => {
          root.render(
            React.createElement(LanguageToggle, {
              language,
              onChange: (newLanguage) => {
                render(newLanguage);
              },
            })
          );
        };

        render(initialLanguage);
      }
    });

    onUnmounted(() => {
      if (root) {
        root.unmount();
      }
    });

    return { container };
  },
};
</script>

<style>
.language-toggle-wrapper {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-left: 16px;
}

.separator {
  width: 1px;
  height: 24px;
  background-color: var(--vp-c-divider);
}

.language-toggle-container {
  display: flex;
  align-items: center;
}
</style>

