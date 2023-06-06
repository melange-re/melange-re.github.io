import "./App.css";
import * as React from "react";
import Editor from "@monaco-editor/react";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";

const langMap = {
  Reason: "Reason",
  OCaml: "OCaml",
};

function LanguageToggle() {
  const [lang, setLang] = React.useState(langMap.Reason);
  return <div className="Toggle">OCaml | ReasonML</div>;
}

function MiniSidebarMenu() {
  return (
    <div className="Menu">
      <div className="Logo">
        <p>{"M"}</p>
      </div>
      <div className="ActionMenu">
        <button>{"R"}</button>
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
        <button>{"Run"}</button>
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

function App() {
  return (
    <div className="App debug">
      <Sidebar />
      <div className="Layout">
        <PanelGroup direction="horizontal">
          <Panel collapsible={false} defaultSize={45}>
            <LanguageToggle />
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
                      defaultValue="// Write ReasonML or OCaml here"
                    />
                  </div>
                </Panel>
                <PanelResizeHandle className="ResizeHandle" />
                <Panel collapsible={true} defaultSize={20}>
                  Problems
                  <div className="Problems" />
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
                      value="// Generated code by Melange"
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
