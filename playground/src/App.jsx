import "../../_opam/bin/jsoo_main.bc";
import "../../_opam/bin/belt-cmijs";
import "../../_opam/bin/runtime-cmijs";
import "../../_opam/bin/stdlib-cmijs";
import "../../_build/default/playground/reason-react-cmijs";
import "./App.css";
import * as React from "react";
import Editor, { useMonaco } from "@monaco-editor/react";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import examples from "./examples";
import { language as mlLanguage } from "./ml_syntax";
import { language as reLanguage } from "./re_syntax";
import { useWorkerizedReducer } from "use-workerized-reducer/react";

const langMap = {
  Reason: "Reason",
  OCaml: "OCaml",
};

// Spin up the worker running the reducers.
const worker = new Worker(new URL("./evalWorker.js", import.meta.url), {
  type: "module",
});

function LanguageToggle({ onChange }) {
  return (
    <div className="Toggle">
      <button onClick={() => onChange(langMap.OCaml)}>OCaml</button>
      <button onClick={() => onChange(langMap.Reason)}>Reason</button>
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
        <button>{"GitHub"}</button>
        <button>{"OPAM"}</button>
      </div>
    </div>
  );
}

function MaxiSidebarMenu({ onExampleClick }) {
  const [isExamplesOpen, setIsExamplesOpen] = React.useState(false);
  return (
    <div className="Menu">
      <div className="Logo">
        <p>{"Melange"}</p>
      </div>
      <div className="ActionMenu">
        <button>{"Format"}</button>
        <button>{"Share"}</button>
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
          : React.null}
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

function Sidebar({ onExampleClick }) {
  const [sidebarColapsed, setSidebarColapsed] = React.useState(false);
  const toggleSidebar = () => setSidebarColapsed(!sidebarColapsed);
  const root = "Sidebar " + (sidebarColapsed ? "colapsed" : "");

  return (
    <div className={root}>
      {sidebarColapsed ? (
        <MiniSidebarMenu />
      ) : (
        <MaxiSidebarMenu onExampleClick={onExampleClick} />
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

function App() {
  const [input, setInput] = React.useState({
    lang: langMap.OCaml,
    code: examples[0].ml,
  });
  const [isLiveEnabled, setIsLiveEnabled] = React.useState(false);
  let output = undefined;
  try {
    output =
      input.lang == langMap.Reason
        ? ocaml.compileRE(input.code)
        : ocaml.compileML(input.code);
  } catch (error) {
    output = { js_error_msg: error.message };
  }
  const javascriptCode = output.js_code || 'Error: check the "Problems" panel';
  const problems = output.js_error_msg || "";

  const [state, dispatch, busy] = useWorkerizedReducer(
    worker,
    "eval", // Reducer name
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
      monaco.languages.register({ id: langMap.OCaml });
      monaco.languages.setMonarchTokensProvider(langMap.OCaml, mlLanguage);
      monaco.languages.register({ id: langMap.Reason });
      monaco.languages.setMonarchTokensProvider(langMap.Reason, reLanguage);
    }
  }, [monaco]);

  React.useEffect(() => {
    // or make sure that it exists by other ways
    if (monaco && editorRef.current) {
      const owner = "playground";
      if (output.js_error_msg) {
        monaco.editor.setModelMarkers(editorRef.current.getModel(), owner, [
          {
            startLineNumber: output.row + 1,
            startColumn: output.column + 1,
            endLineNumber: output.endRow + 1,
            endColumn: output.endColumn + 1,
            message: output.text,
            severity: monaco.MarkerSeverity.Error,
          },
        ]);
      } else {
        monaco.editor.removeAllMarkers(owner);
      }
    }
  }, [monaco, output]);

  React.useEffect(() => {
    if (state.bundledCode) {
      // https://github.com/rollup/rollup/wiki/Troubleshooting#avoiding-eval
      const eval2 = eval;
      try {
        eval2(state.bundledCode);
      } catch (e) {
        console.error(e);
      }
    }
  }, [state.bundledCode]);

  React.useEffect(() => {
    dispatch({ type: "eval", code: output.js_code });
  }, [output.js_code]);

  return (
    // <div className="App debug">
    <div className="App">
      <Sidebar
        onExampleClick={(example) => {
          let exampleCode =
            input.lang == langMap.Reason ? example.re : example.ml;
          setInput({ lang: input.lang, code: exampleCode });
        }}
      />
      <div className="Layout">
        <PanelGroup direction="horizontal">
          <Panel collapsible={false} defaultSize={45}>
            <LanguageToggle
              onChange={(language) => {
                if (language != input.lang) {
                  let newCode = input.code;
                  if (language == langMap.Reason) {
                    try {
                      newCode = ocaml.printRE(ocaml.parseML(input.code));
                      setInput({ lang: langMap.Reason, code: newCode });
                    } catch (error) {}
                  } else {
                    try {
                      newCode = ocaml.printML(ocaml.parseRE(input.code));
                      setInput({ lang: langMap.OCaml, code: newCode });
                    } catch (error) {}
                  }
                }
              }}
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
                      language={input.lang}
                      value={input.code}
                      onMount={handleEditorDidMount}
                      onChange={(code) =>
                        setInput({ lang: input.lang, code: code })
                      }
                    />
                  </div>
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <Panel collapsible={true} defaultSize={20}>
                  Problems
                  <div className="Problems">{problems}</div>
                </Panel>
              </PanelGroup>
            </div>
          </Panel>
          <PanelResizeHandle className="ResizeHandle" />
          <Panel collapsible={false} defaultSize={45}>
            <div className="Toggle">
              <button onClick={() => setIsLiveEnabled(true)}>Live</button>
              <button onClick={() => setIsLiveEnabled(false)}>
                Generated code
              </button>
            </div>
            <div className="Right">
              <PanelGroup direction="vertical">
                <Panel collapsible={false} defaultSize={80}>
                  {isLiveEnabled ? (
                    <Live />
                  ) : (
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
                        language={output.js_error_msg ? "text" : "javascript"}
                        value={javascriptCode}
                      />
                    </div>
                  )}
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <Panel collapsible={true} defaultSize={20}>
                  Console
                  <div className="Console" />
                  {state.logs.map((log, i) => (
                    <div key={i}>{log.items.join(" ")}</div>
                  ))}
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
