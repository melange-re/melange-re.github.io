const overridableFunctionNames = ['log', 'warn', 'info', 'debug', 'error'];

console.original = {}

globalThis.captures = [];
let consoleOverriden = false;

let saveLog = (functionName, args) => {
  const finalArgs = args.map(arg => {
    if (typeof arg == 'object') {
      if (arg instanceof Error) {
        return JSON.stringify(arg, Object.getOwnPropertyNames(arg));
        // todo: some way to identify this string from other json stringified strings
        // https://stackoverflow.com/a/17936621/11565176
      }
      return JSON.stringify(arg);
    } else {
      return arg;
    }
  });
  globalThis.captures.push({
    kind: functionName,
    args: finalArgs,
    date: Date.now(),
  });
};

let setProxy = (allowOriginalExecution = false) => {
  const proxyHandler = {
    apply: (target, thisArgument, argumentsList) => {
      saveLog(target.name, argumentsList);
      target.bind(thisArgument);
      if (allowOriginalExecution) return target(...argumentsList);
      return;
    },
  };

  overridableFunctionNames.forEach(funcName => {
    if (!consoleOverriden) {
      console.original[funcName] = console[funcName];
    }
    console[funcName] = new Proxy(console[funcName], proxyHandler);
  });
  consoleOverriden = true;
}

let resetToOriginalFunctions = () => {
  if (consoleOverriden) {
    overridableFunctionNames.forEach(funcName => {
      console[funcName] = console.original[funcName];
    });
  }
  consoleOverriden = false;
}

export let start = (allowOriginalExecution = false) => {
  globalThis.captures = [];
  setProxy(allowOriginalExecution);
};

export let stop = () => {
  resetToOriginalFunctions();
}

export let flush = () => {
  globalThis.captures = [];
}

export let getCaptures = () => {
  return globalThis.captures;
}

export let printCaptures = () => {
  return globalThis.captures.map(capture => { return capture.args.join(" ") });
}

let makeOriginalLog = (log) => {
  resetToOriginalFunctions();

  if (overridableFunctionNames.includes(log.function)) {
    const finalArgs = log.args.map(arg => {
      if (typeof arg == 'string') {
        try {
          const obj = JSON.parse(arg);
          return obj.stack ? obj.stack : obj;
        } catch {
          return arg;
        }
      }
      return arg;
    });
    console[log.function](...finalArgs);
  } else {
    throw Error('Invalid Log type');
  }
}
