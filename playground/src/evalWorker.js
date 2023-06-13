import { initWorkerizedReducer } from "use-workerized-reducer";
import { rollup } from "@rollup/browser";
const rawModules = import.meta.glob("./node_modules_playground/**/*.js", {
  as: "raw",
  eager: true,
});

const modules = {};

Object.keys(rawModules).forEach((k) => {
  const value = rawModules[k];
  modules[k.replace("./node_modules_playground/", "")] = value;
});
console.log(modules);

// modules[
//   "main.js"
// ] = `import * as Belt_List from "melange.belt/belt_List.js"; var t = Belt_List.map;`;
modules[
  "main.js"
] = `import foo from 'foo.js'; console.log(foo);`;
modules[
  "foo.js"
] = `export default 42;`;

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

        const bundle = await rollup({
          input: "main.js",
          plugins: [
            {
              name: "loader",
              resolveId(source) {
                if (modules.hasOwnProperty(source)) {
                  return source;
                } else {
                  console.log("NOT FOUND", source);
                }
              },
              load(id) {
                if (modules.hasOwnProperty(id)) {
                  return modules[id];
                } else {
                  console.log("load NOT FOUND", source);
                }
              },
            },
          ],
        });
        const { output } = await bundle.generate({ format: "iife" });
        try {
          eval2(output[0].code);
        } catch {
          console.log(output);
        }
        state.logs = buffer;
        break;
      default:
        throw new Error();
    }
  }
);
