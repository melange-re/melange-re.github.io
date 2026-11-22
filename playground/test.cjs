const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");

globalThis.require = require;
for (const file of process.argv.slice(2)) {
  vm.runInThisContext(fs.readFileSync(file, "utf8"), {
    filename: path.resolve(file),
  });
}

function parse(source) {
  const result = ocamlformat.parse(source);
  assert.ok(result.ast, result.js_warning_error_msg);
  return result.ast;
}

function compile(source) {
  const result = ocaml.compileAST(source, parse(source));
  assert.ok(result.js_code, result.js_warning_error_msg);
  return result;
}

function format(source) {
  const [status, result] = ocamlformat.format(source);
  assert.equal(status, 0, result);
  assert.equal(typeof result, "string");
  return result;
}

function convertReason(source) {
  const [status, result] = ocamlformat.convertReason(source);
  assert.equal(status, 0, result);
  assert.equal(typeof result, "string");
  return result;
}

const plain = "let answer=21*2";
assert.deepEqual(compile(plain), ocaml.compileML(plain));
assert.match(format(plain), /let answer = 21 \* 2/);
const ordinary = 'let less x y = x<y\n(* Keep x<y here. *)\nlet text = "x<y"';
assert.deepEqual(compile(ordinary), ocaml.compileML(ordinary));
const formattedOrdinary = format(ordinary);
assert.match(formattedOrdinary, /x < y/);
assert.match(formattedOrdinary, /\(\* Keep x<y here\. \*\)/);
assert.match(formattedOrdinary, /"x<y"/);

const source = `(* Keep this comment. *)
module Greeting = struct
  (** A greeting component. *)
  let make ~name () = <button className="greeting">(React.string name)</button>
  [@@react.component]
end
let node = <><Greeting name="MLX" /><span>(React.string "Hello!")</span></>
let answer = 42
`;
const compiled = compile(source);
assert.match(compiled.js_code, /react\/jsx-runtime/);
assert.ok(compiled.type_hints.some((hint) =>
  hint.start.line === 8 && hint.hint.includes("int")));
const formatted = format(source);
assert.match(formatted, /<Greeting name="MLX"\s*\/>/);
assert.match(formatted, /<button className="greeting">/);
assert.equal(format(formatted), formatted);
compile(formatted);

const reason = ocaml.printRE(parse(source));
assert.match(reason, /<Greeting name="MLX"\s*\/>/);
assert.equal(reason.split("Keep this comment.").length, 2);
assert.equal(reason.split("A greeting component.").length, 2);
assert.ok(ocaml.compileRE(reason).js_code);
const roundTrip = convertReason(reason);
assert.match(roundTrip, /<Greeting name="MLX"\s*\/>/);
assert.equal(roundTrip.split("Keep this comment.").length, 2);
assert.equal(roundTrip.split("A greeting component.").length, 2);
compile(roundTrip);

const forwardedChildren = convertReason(`
let children = React.array([|React.string("Hello!")|]);
let node = <div children />;
`);
assert.match(forwardedChildren, /<div>\s*\.\.\.children\s*<\/div>/);
assert.doesNotMatch(forwardedChildren, /\[@JSX\]/);
compile(forwardedChildren);

const quotedKeys = convertReason(`
let headers = {
  "literal-key": "application/json",
  "Content-Type": "text/plain",
  "method": "GET",
  "type": "cors",
};
`);
assert.match(quotedKeys, /\[@mel.as "literal-key"\]/);
const quotedKeysJS = compile(quotedKeys).js_code;
assert.match(quotedKeysJS, /"literal-key"/);
assert.match(quotedKeysJS, /"Content-Type"/);

const constructors = convertReason(`
type pair = Pair(int, string);
let value = Some(Pair(1, "one"));
`);
assert.doesNotMatch(constructors, /explicit_arity|reason.preserve_braces/);
compile(constructors);

const unicode = convertReason('let greeting = "Olá 👋";');
assert.match(unicode, /Olá 👋/);
compile(unicode);

for (const invalidReason of ["let =", 'let object = {"1279": 1};']) {
  const [status, diagnostic] = ocamlformat.convertReason(invalidReason);
  assert.equal(status, 1);
  assert.equal(typeof diagnostic, "string");
  assert.ok(diagnostic.length > 0);
}
compile(convertReason("let answer = 42;"));

const spread = `let className = Some "greeting"
let children = React.array [|React.string "Hello!"|]
let node = <div ?className>...children</div>`;
compile(spread);
compile(format(spread));
assert.ok(ocaml.compileRE(ocaml.printRE(parse(spread))).js_code);

const invalid = ocamlformat.parse("let node =\n  <div></span>");
assert.equal(invalid.type, "error");
assert.equal(invalid.row, 1);
assert.ok(Number.isInteger(invalid.column));
assert.match(invalid.text, /Syntax error/);
assert.equal(ocamlformat.format("let node = <div>")[0], 1);
for (const hole of ["let x = _", "module X = _"]) {
  assert.equal(ocamlformat.parse(hole).type, "error");
}

const typeError = "let node =\n  <div>(React.string 123)</div>";
const error = ocaml.compileAST(typeError, parse(typeError));
assert.equal(error.type, "error");
assert.equal(error.row, 1);
assert.equal(error.column, typeError.split("\n")[1].indexOf("123"));
assert.match(error.text, /int/);
assert.match(error.text, /string/);
compile(source);

async function checkExamples() {
  const { headers } = await import(`data:text/javascript;base64,${Buffer.from(quotedKeysJS).toString("base64")}`);
  assert.deepEqual(headers, {
    "literal-key": "application/json",
    "Content-Type": "text/plain",
    method: "GET",
    type: "cors",
  });
  const { default: examples } = await import("./src/examples.js");
  for (const example of examples) {
    compile(example.ml);
    compile(format(example.ml));
    assert.ok(ocaml.compileRE(example.re).js_code, example.name);
    compile(convertReason(example.re));
  }
  console.log("OCaml/MLX parsing, formatting, compilation, locations, Reason-to-MLX conversion, round trips, and examples passed.");
}

checkExamples().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
