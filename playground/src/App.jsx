import "../../_opam/bin/jsoo_main.bc";
import "../../_opam/bin/belt-cmijs";
import "../../_opam/bin/runtime-cmijs";
import "../../_opam/bin/stdlib-cmijs";
import "../../_opam/bin/format.bc.js";
import "../../_build/default/playground/reason-react-cmijs";
import "./App.css";
import * as React from "react";
import Editor, { useMonaco } from "@monaco-editor/react";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { useWorkerizedReducer } from "use-workerized-reducer/react";
import { useDebounce } from 'use-debounce';

import * as Router from './Router';
import { useLocalStorage } from './LocalStorage';
import examples from "./examples";
import { language as OCamlSyntax } from "./ml_syntax";
import { language as ReasonSyntax } from "./re_syntax";

const languageMap = {
  Reason: "Reason",
  OCaml: "OCaml",
};

const LIVE_PREVIEW = {
  ON: "on",
  OFF: "off",
};

// Spin up the worker running the reducers.
const worker = new Worker(new URL("./Worker.js", import.meta.url), {
  type: "module",
});

function VisuallyHidden({ when, children }) {
  return (
    <div
      style={when ? {
        position: "absolute",
        top: "-10000px",
        left: "-10000px",
        visibility: "hidden",
      } : {
        visibility: "visible",
        height: "100%"
      }}
    >
      {children}
    </div>
  );
}

function LanguageToggle({ language, onChange }) {
  return (
    <div className="Toggle">
      <button
        className={language === languageMap.OCaml ? "active" : ""}
        onClick={() => onChange(languageMap.OCaml)}
      >
        OCaml
      </button>
      <button
        className={language === languageMap.Reason ? "active" : ""}
        onClick={() => onChange(languageMap.Reason)}
      >
        Reason
      </button>
    </div>
  );
}

function MiniSidebarMenu() {
  return (
    <div className="Menu">
      <div className="Logo">
        <p>{"M"}</p>
      </div>
      <div className="ActionMenu">
        <button>{"F"}</button>
        <button>{"S"}</button>
        <hr className="Separator" />
        <button>{"E"}</button>
        <button>{"S"}</button>
        <hr className="Separator" />
        <button>{"G"}</button>
        <button>{"O"}</button>
      </div>
    </div>
  );
}

function MaxiSidebarMenu({ onFormat, onShare, onExampleClick }) {
  const [isExamplesOpen, setIsExamplesOpen] = React.useState(false);
  return (
    <div className="Menu">
      <div className="Logo">
        <p>{"Melange"}</p>
      </div>
      <div className="ActionMenu">
        <button onClick={onFormat}>{"Format"}</button>
        <button onClick={(_) => onShare()}>{"Share"}</button>
        <hr className="Separator" />
        <button onClick={() => setIsExamplesOpen(!isExamplesOpen)}>
          {"Examples"}
        </button>
        {isExamplesOpen
          ? examples.map((example) => (
              <button
                key={example.name}
                onClick={(_) => onExampleClick(example)}
              >
                {example.name}
              </button>
            ))
          : null}
        <button>{"Settings"}</button>
        <hr className="Separator" />
        <button>{"GitHub"}</button>
        <button>{"OPAM"}</button>
      </div>
      <div className="Info">
        <span>{"Info:"}</span>
        <div className="Versions">
          <span>{"Melange: v1.0"}</span>
          <span>{"OCaml: v4.14.1"}</span>
          <span>{"Reason: v3.9.0"}</span>
        </div>
      </div>
    </div>
  );
}

function Sidebar({ onFormat, onShare, onExampleClick }) {
  const [sidebarColapsed, setSidebarColapsed] = React.useState(false);
  const toggleSidebar = () => setSidebarColapsed(!sidebarColapsed);
  const root = "Sidebar " + (sidebarColapsed ? "colapsed" : "");

  return (
    <div className={root}>
      {sidebarColapsed ? (
        <MiniSidebarMenu />
      ) : (
        <MaxiSidebarMenu onFormat={onFormat} onExampleClick={onExampleClick} onShare={onShare} />
      )}
      <button onClick={(_) => toggleSidebar()}>
        {sidebarColapsed ? ">>>" : "<<<"}
      </button>
    </div>
  );
}

function Live() {
  return (
    <div id="preview" className="cleanslate">
      <p>
        This div has the ID <code>preview</code>.
      </p>
      <p>
        Feel free to override its content, or choose "React Greetings" in the
        Examples menu!
      </p>
    </div>
  );
}

function ConsoleLogs ({ logs }) {
  const bottomOfTheConsole = React.useRef(null);

  React.useEffect(() => {
    bottomOfTheConsole.current.scrollIntoView();
  }, [logs]);

  return (
    <div className="Console">
      {logs.map((log, i) => (
        <div className="Item" key={i}>{log.items.join(" ")}</div>
      ))}
      <div ref={bottomOfTheConsole} />
    </div>
  )
}

const encodeCode = (store) => {
  try {
    let encoded = btoa(store?.code || "");
    return { ...store, code: encoded }
  } catch (e) {
    return store
  }
};

const decodeCode = (store) => {
  try {
    let decoded = atob(store?.code || "");
    return { ...store, code: decoded }
  } catch (e) {
    return store
  }
};

function useStore (defaultValue) {
  /* This store gets the data from LocalStorage and the URL (queryParams),
    and needs a defaultValue in case of both being empty.

    The URL has priority over LocalStorage: to make sure people who recieve
    a URL with queryParams reads the values from the URL instead of the last LocalStorage session.

    When updating the store, set's a React state, updates LocalStorage and URL.
  */
  const LOCAL_STORAGE_ITEM = "__store"
  const [search, setSearch] = Router.useSearchParams();
  const [localStorage, setLocalStorage] = useLocalStorage(LOCAL_STORAGE_ITEM, defaultValue);
  const keys = Object.keys(defaultValue);
  /* Get only searchParams that we care (from defaultValue keys) */
  const knownSearchParams = Object.entries(search).map(([key, value]) => {
    if (keys.includes(key)) {
      return [key, value]
    } else {
      return null
    }
  }).filter(a => !!a) || [];
  const initialStateFromUrl = knownSearchParams.reduce((previous, [key, value]) => {
    return { ...previous, [key]: value }
  }, {});
  const initialValue = decodeCode({ ...localStorage, ...initialStateFromUrl });
  const [state, setState] = React.useState(initialValue);

  React.useEffect(() => {
    let encodedeState = encodeCode(state);
    setSearch(encodedeState);
    setLocalStorage(encodedeState);
  }, [state])

  return [state, setState];
};

function formatOCaml (code) {
  let result = window.ocamlformat.format(code);
  if (!Array.isArray(result)) {
    return code;
  }
  // result is [int, string]
  //           int -> represents (0) Ok, (1) Error
  //           string -> the formated code or the error message
  const kind = result[0];
  const payload = result[1];
  const OK = 0;
  const ERROR = 1;
  if (kind === OK) {
    return payload
  } else if (kind === ERROR) {
    console.log(payload)
    return code
  }
};

const formatReason = (code) => {
  try {
    return ocaml.printRE(ocaml.parseRE(code));
  } catch (e) {
    console.log(e);
    return code;
  }
}

function OutputEditor ({ language, value }) {
  const [debouncedValue] = useDebounce(value, 500);

  return (
    <div className="Editor">
      <Editor
        theme="vs-dark"
        options={{
          readOnly: true,
          minimap: {
            enabled: false,
          },
        }}
        height="100%"
        language={language}
        value={debouncedValue}
      />
    </div>
  )
}

function App() {
  const defaultState = {
    language: languageMap.OCaml,
    code: examples[0].ml,
    live: LIVE_PREVIEW.OFF
  };
  const [state, setState] = useStore(defaultState);
  const { language, code, live } = state;
  const setLive = (live) => setState({ ...state, live });
  const setCode = (code) => setState({ ...state, code });
  const setInput = ({language, code}) => setState({ ...state, language, code });

  let compilation = undefined;
  try {
    compilation =
      language == languageMap.Reason
        ? ocaml.compileRE(code)
        : ocaml.compileML(code);
  } catch (error) {
    compilation = { js_error_msg: error.message };
  }
  const javascriptCode = compilation.js_code || compilation.js_error_msg || "";
  const problems = compilation.js_error_msg || "";

  const [workerState, dispatch, busy] = useWorkerizedReducer(
    worker,
    "bundle", // Reducer name
    { logs: [] } // Initial state
  );

  const editorRef = React.useRef(null);

  function handleEditorDidMount(editor, _monaco) {
    editorRef.current = editor;
  }

  const monaco = useMonaco();

  React.useEffect(() => {
    // or make sure that it exists by other ways
    if (monaco) {
      monaco.languages.register({ id: languageMap.OCaml });
      monaco.languages.setMonarchTokensProvider(languageMap.OCaml, OCamlSyntax);
      monaco.languages.register({ id: languageMap.Reason });
      monaco.languages.setMonarchTokensProvider(languageMap.Reason, ReasonSyntax);
    }
  }, [monaco]);

  React.useEffect(() => {
    // or make sure that it exists by other ways
    if (monaco && editorRef.current) {
      const owner = "playground";
      if (compilation.js_error_msg) {
        monaco.editor.setModelMarkers(editorRef.current.getModel(), owner, [
          {
            startLineNumber: compilation.row + 1,
            startColumn: compilation.column + 1,
            endLineNumber: compilation.endRow + 1,
            endColumn: compilation.endColumn + 1,
            message: compilation.text,
            severity: monaco.MarkerSeverity.Error,
          },
        ]);
      } else {
        monaco.editor.removeAllMarkers(owner);
      }
    }
  }, [monaco, compilation]);

  React.useEffect(() => {
    if (workerState.bundledCode) {
      // https://github.com/rollup/rollup/wiki/Troubleshooting#avoiding-eval
      const eval2 = eval;
      try {
        eval2(workerState.bundledCode);
      } catch (e) {
        console.error(e);
      }
    }
  }, [workerState.bundledCode]);

  React.useEffect(() => {
    if (compilation.js_code) {
      dispatch({ type: "bundle", code: compilation.js_code });
    }
  }, [compilation.js_code]);

  const onLanguageToggle = (newLanguage) => {
    const sameLanguage = newLanguage == language;
    if (sameLanguage) {
      return
    }

    if (newLanguage == languageMap.Reason) {
      try {
        let newReasonCode = ocaml.printRE(ocaml.parseML(code))
        setInput({ language: newLanguage, code: newReasonCode });
      } catch (error) {
        setInput({ language: newLanguage, code });
        console.log(error);
      }
    } else if (newLanguage == languageMap.OCaml) {
      try {
        let newOCamlCode = ocaml.printML(ocaml.parseRE(code));
        setInput({ language: newLanguage, code: newOCamlCode });
      } catch (error) {
        setInput({ language: newLanguage, code });
        console.log(error);
      }
    } else {
      return
    }
  };

  const copyToClipboard = () => {
    navigator.clipboard.writeText(window.location.href);
    alert("copied to clipboard!:\n\n" + window.location.href)
  };

  const formatCode = React.useCallback(() => {
    if (language == languageMap.Reason) {
      let newReasonCode = formatReason(code);
      setCode(newReasonCode);
    } else {
      let newOCamlCode = formatOCaml(code);
      setCode(newOCamlCode);
    }
  }, [language, code]);

  return (
    <div className="App">
      <Sidebar
        onShare={copyToClipboard}
        onFormat={formatCode}
        onExampleClick={(example) => {
          let code = language == languageMap.Reason ? example.re : example.ml;
          setInput({ language, code });
        }}
      />
      <div className="Layout">
        <PanelGroup direction="horizontal">
          <Panel collapsible={false} defaultSize={45}>
            <LanguageToggle
              language={language}
              onChange={onLanguageToggle}
            />
            <div className="Left">
              <PanelGroup direction="vertical">
                <Panel collapsible={false} defaultSize={80}>
                  <div className="Editor">
                    <Editor
                      options={{
                        minimap: {
                          enabled: false,
                        },
                      }}
                      theme="vs-dark"
                      height="100%"
                      language={language}
                      value={code}
                      onMount={handleEditorDidMount}
                      onChange={setCode}
                    />
                  </div>
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <span>Problems</span>
                <Panel collapsible={true} defaultSize={20}>
                  <div className="Problems">{problems}</div>
                </Panel>
              </PanelGroup>
            </div>
          </Panel>
          <PanelResizeHandle className="ResizeHandle" />
          <Panel collapsible={false} defaultSize={45}>
            <div className="Right">
              <PanelGroup direction="vertical">
                <Panel collapsible={false} defaultSize={80}>
                <div className="Toggle">
                  <button
                    className={live === LIVE_PREVIEW.ON ? "active" : ""}
                    onClick={() => setLive(LIVE_PREVIEW.ON)}>Live</button>
                  <button
                    className={live === LIVE_PREVIEW.OFF ? "active" : ""}
                    onClick={() => setLive(LIVE_PREVIEW.OFF)}>JavaScript output</button>
                </div>
                  <VisuallyHidden when={live === LIVE_PREVIEW.OFF}>
                    <Live />
                  </VisuallyHidden>
                  <VisuallyHidden when={live === LIVE_PREVIEW.ON}>
                    <OutputEditor
                      language={compilation.js_error_msg ? "text" : "javascript"}
                      value={javascriptCode}
                      onMount={handleEditorDidMount}
                    />
                  </VisuallyHidden>
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <span>Console</span>
                <Panel collapsible={true} defaultSize={20}>
                  <ConsoleLogs logs={workerState.logs} />
                </Panel>
              </PanelGroup>
            </div>
          </Panel>
        </PanelGroup>
      </div>
    </div>
  );
}

export default App;
