import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  ignoreDeadLinks: true,
  plugins: [react()],
  build: {
    outDir: "../docs/public/playground",
    rollupOptions: {
      treeshake: false
    }
  },
  base: "./",
});
