import "../../_opam/bin/jsoo_main.bc";
import "../../_opam/bin/belt-cmijs";
import "../../_opam/bin/runtime-cmijs";
import "../../_opam/bin/stdlib-cmijs";
import "./App.css";
import * as React from "react";
import Editor from "@monaco-editor/react";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";

const langMap = {
  Reason: "Reason",
  OCaml: "OCaml",
};

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

function MaxiSidebarMenu() {
  return (
    <div className="Menu">
      <div className="Logo">
        <p>{"Melange"}</p>
      </div>
      <div className="ActionMenu">
        <button>{"Format"}</button>
        <button>{"Share"}</button>
        <hr className="Separator" />
        <button>{"Examples"}</button>
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

function Sidebar() {
  const [sidebarColapsed, setSidebarColapsed] = React.useState(false);
  const toggleSidebar = () => setSidebarColapsed(!sidebarColapsed);
  const root = "Sidebar " + (sidebarColapsed ? "colapsed" : "");

  return (
    <div className={root}>
      {sidebarColapsed ? <MiniSidebarMenu /> : <MaxiSidebarMenu />}
      <button onClick={(_) => toggleSidebar()}>
        {sidebarColapsed ? ">>>" : "<<<"}
      </button>
    </div>
  );
}

const defaultCode = `type tree = Leaf | Node of int * tree * tree

let rec sum item =
  match item with
  | Leaf -> 0
  | Node (value, left, right) -> value + sum left + sum right

let myTree =
  Node
    ( 1,
      Node (2, Node (4, Leaf, Leaf), Node (6, Leaf, Leaf)),
      Node (3, Node (5, Leaf, Leaf), Node (7, Leaf, Leaf)) )

let () = Js.log (sum myTree)`;

const _anotherExample = `/* Based on https://rosettacode.org/wiki/Factorial#Recursive_50 */
let rec factorial = (n) =>
  n <= 0
  ? 1
  : n * factorial(n - 1);

Js.log(factorial(6));`

function App() {
  const [input, setInput] = React.useState({
    lang: langMap.OCaml,
    code: defaultCode,
  });
  console.log(input);
  const output =
    input.lang == langMap.Reason
      ? ocaml.compile(ocaml.printML(ocaml.parseRE(input.code)))
      : ocaml.compile(input.code);
  console.log(output);
  const javascriptCode = output.js_code || 'Error: check the "Problems" panel';
  const problems = output.js_error_msg || "";

  return (
    <div className="App debug">
      <Sidebar />
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
                    } catch (error) {}
                    setInput({ lang: langMap.Reason, code: newCode });
                  } else {
                    try {
                      newCode = ocaml.printML(ocaml.parseRE(input.code));
                    } catch (error) {}
                    setInput({ lang: langMap.OCaml, code: newCode });
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
                      defaultLanguage="reasonml"
                      value={input.code}
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
            <div className="Toggle">Live | Generated code</div>
            <div className="Right">
              <PanelGroup direction="vertical">
                <Panel collapsible={false} defaultSize={80}>
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
                      defaultLanguage="reasonml"
                      defaultValue="// Generated code by Melange"
                      value={javascriptCode}
                    />
                  </div>
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <Panel collapsible={true} defaultSize={20}>
                  Console
                  <div className="Console" />
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
