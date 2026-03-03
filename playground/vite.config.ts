import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { readFile } from "node:fs/promises";

function stripInlineSourcemapsFromBuildArtifacts() {
  const targetFilePath = "/_build/default/playground/format.bc.js";
  const inlineSourceMapComment = /\n\/\/# sourceMappingURL=.*$/gm;

  return {
    name: "strip-inline-sourcemaps-from-build-artifacts",
    enforce: "pre" as const,
    async load(id: string) {
      const filePath = id.split("?", 1)[0];
      if (id.includes("?raw")) {
        return null;
      }
      if (!filePath.endsWith(targetFilePath)) {
        return null;
      }

      const code = await readFile(filePath, "utf8");
      return {
        code: code.replace(inlineSourceMapComment, ""),
        map: null,
      };
    },
  };
}

// https://vitejs.dev/config/
export default defineConfig({
  ignoreDeadLinks: true,
  plugins: [stripInlineSourcemapsFromBuildArtifacts(), react()],
  build: {
    outDir: "../docs/public/playground",
    rollupOptions: {
      treeshake: false
    }
  },
  base: "./",
});
