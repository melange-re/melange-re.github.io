import { initWorkerizedReducer } from "use-workerized-reducer";
import { rollup } from "@rollup/browser";

import * as Console from "./console";

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

// https://rollupjs.org/troubleshooting/#avoiding-eval
const eval2 = eval;

/** @type {Map<string, Promise<{ url: string; body: string; }>>} */
const FETCH_CACHE = new Map();

/**
 * @param {string} url
 * @param {number} uid
 */
async function fetch_if_uncached(url) {
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

initWorkerizedReducer(
  "bundle", // Name of the reducer
  async (state, action) => {
    // Reducers can be async.
    // Manipulate `state` directly. ImmerJS will take
    // care of maintaining referential equality.
    switch (action.type) {
      case "clear.logs":
        Console.flush();
        state.logCaptures = [];
        break;
      case "bundle":
        const code = action.code;
        if (!code) {
          return
        }
        Console.start();

        /* Reset logs if there's some */
        Console.flush();

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
                  const pkg = importer.substring(
                    0,
                    importer.lastIndexOf("/") + 1
                  );
                  source = pkg + source.substring(2, importee.length);
                }
                if (modules.hasOwnProperty(source)) {
                  return source;
                } else {
                  if (importee[0] == "/") {
                    return "https://esm.sh" + importee;
                  } else if (importee.substring(0, 8) != "https://") {
                    return "https://esm.sh/" + importee;
                  } else {
                    // TODO: Improve versioning.
                    // We are getting "react" and "react-dom" from stable,
                    // which might change under our backs.
                    return importee;
                  }
                }
              },
              async load(resolved) {
                if (modules.hasOwnProperty(resolved)) {
                  return modules[resolved];
                } else {
                  const res = await fetch_if_uncached(resolved);
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
        try {
          // bundling always happens in worker as it's expensive. Evaluation too,
          // but if there is DOM manipulation, then defer evaluation to the
          // main thread, as worker doesn't have access to DOM
          if (code.indexOf("react/jsx-runtime") >= 0 || code.indexOf("react-dom/client") >= 0) {
            state.bundledCode = output[0].code;
          } else {
            state.bundledCode = undefined;
            eval2(output[0].code);
          }
        } catch (e) {
          console.error("Error while evaluating JavaScript code: " + e.message);
        }
        // We always set logCaptures, if `code` is undefined we will erase them
        state.logCaptures = Console.getCaptures();
        Console.stop();
        break;
      default:
        throw new Error();
    }
  }
);
