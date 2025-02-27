const overridableFunctionNames = ['log', 'warn', 'info', 'debug', 'error'];

console.original = {}

let captures = [];
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
  captures.push({
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
  captures = [];
  setProxy(allowOriginalExecution);
};

export let stop = () => {
  resetToOriginalFunctions();
}

export let flush = () => {
  captures = [];
}

export let getCaptures = () => {
  return captures;
}
