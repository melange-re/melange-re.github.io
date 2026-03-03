import { rollup } from "@rollup/browser";

const modules = {};

const rawModules = import.meta.glob(
  "../../_build/default/playground/output/node_modules/**/*.js",
  {
    as: "raw",
    eager: true,
  }
);

Object.keys(rawModules).forEach((k) => {
  const value = rawModules[k];
  modules[
    k.replace("../../_build/default/playground/output/node_modules/", "")
  ] = value;
});

const FETCH_CACHE = new Map();

async function fetchIfUncached(url) {
  if (FETCH_CACHE.has(url)) {
    return FETCH_CACHE.get(url);
  }

  const promise = fetch(url)
    .then(async (r) => {
      if (!r.ok) throw new Error(await r.text());

      return {
        url: r.url,
        body: await r.text(),
      };
    })
    .catch((err) => {
      FETCH_CACHE.delete(url);
      throw err;
    });

  FETCH_CACHE.set(url, promise);
  return promise;
}

async function bundleCode(code) {
  modules["main.js"] = code;

  const bundle = await rollup({
    input: "main.js",
    plugins: [
      {
        name: "loader",
        resolveId(importee, importer) {
          var source = importee;
          const isRelative = importee.substring(0, 2) == "./";
          if (isRelative && importer) {
            const pkg = importer.substring(0, importer.lastIndexOf("/") + 1);
            source = pkg + source.substring(2, importee.length);
          }
          if (modules.hasOwnProperty(source)) {
            return source;
          } else {
            if (source[0] == "/") {
              return "https://esm.sh" + source;
            } else if (source.substring(0, 8) != "https://") {
              return "https://esm.sh/" + source;
            } else {
              return source;
            }
          }
        },
        async load(resolved) {
          if (modules.hasOwnProperty(resolved)) {
            return modules[resolved];
          } else {
            const res = await fetchIfUncached(resolved);
            return res?.body;
          }
        },
      },
    ],
  });

  const { output } = await bundle.generate({
    format: "iife",
    name: "MelangeApp",
  });

  return output[0].code;
}

self.addEventListener("message", async (event) => {
  const action = event.data;
  if (!action || typeof action !== "object") {
    return;
  }

  if (action.type !== "bundle") {
    return;
  }

  const code = action.code;
  if (!code) {
    return;
  }

  const requestId = action.requestId ?? 0;
  const bundledCodeIsReact = !!action.isReactCode;

  let bundledCode;
  let bundleError;

  try {
    bundledCode = await bundleCode(code);
  } catch (e) {
    bundledCode = undefined;
    bundleError =
      "Error while bundling JavaScript code: " + (e?.message || String(e));
    console.error(bundleError);
  }

  self.postMessage({
    type: "bundle.result",
    requestId,
    bundledCode,
    bundledCodeIsReact,
    bundleError,
  });
});
