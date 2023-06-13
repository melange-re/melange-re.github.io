import { initWorkerizedReducer } from "use-workerized-reducer";
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

const _console = console;

let buffer = [];

const stringify = (value) => JSON.stringify(value) || String(value);

const log = (type, items) => buffer.push({ type, items: items.map(stringify) });

console = {
  log: (...items) => log("log", items),
  error: (...items) => log("error", items),
  warn: (...items) => log("warn", items),
};

// https://rollupjs.org/troubleshooting/#avoiding-eval
const eval2 = eval;

initWorkerizedReducer(
  "eval", // Name of the reducer
  async (state, action) => {
    buffer = [];
    // Reducers can be async.
    // Manipulate `state` directly. ImmerJS will take
    // care of maintaining referential equality.
    switch (action.type) {
      case "eval":
        const code = action.code;
        if (code) {
          modules["main.js"] = code;

          const bundle = await rollup({
            input: "main.js",
            plugins: [
              {
                name: "loader",
                resolveId(importee, importer) {
                  var source = importee;
                  if (importee.substring(0, 2) == "./" && importer) {
                    const pkg = importer.substring(
                      0,
                      importer.lastIndexOf("/") + 1
                    );
                    source = pkg + source.substring(2, importee.length);
                  }
                  if (modules.hasOwnProperty(source)) {
                    return source;
                  }
                },
                load(id) {
                  if (modules.hasOwnProperty(id)) {
                    return modules[id];
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
            eval2(output[0].code);
          } catch (e) {
            console.log(e);
          }
        }
        // We always set logs, if `code` is undefined we will erase them
        state.logs = buffer;
        break;
      default:
        throw new Error();
    }
  }
);
