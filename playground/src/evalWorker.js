import { initWorkerizedReducer } from "use-workerized-reducer";

const _console = console;

let buffer = [];

const stringify = value =>
  JSON.stringify(value) || String(value);

const log = (type, items) =>
  buffer.push({type, items: items.map(stringify)});

console = {
  log: (...items) => log('log', items),
  error: (...items) => log('error', items),
  warn: (...items) => log('warn', items),
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
       eval2(code);
       state.logs = buffer;
       break;
     default:
       throw new Error();
   }
 }
);
