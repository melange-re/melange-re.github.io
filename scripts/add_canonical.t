Test add_canonical exe

  $ cat >foo.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat foo.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/foo.html" /></head>


  $ mkdir -p melange/Js/Global
  $ cat > ./melange/Js/Global/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Node/Foo
  $ cat > ./melange/Node/Foo/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Dom/Storage2
  $ cat > ./melange/Dom/Storage2/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt
  $ cat > ./melange/Belt/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt/List
  $ cat > ./melange/Belt/List/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Stdlib/Int
  $ cat > ./melange/Stdlib/Int/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js/TypedArray2
  $ cat > ./melange/Js/TypedArray2/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js/Typed_array
  $ cat > ./melange/Js/Typed_array/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js/TypedArray2
  $ cat > ./melange/Js/TypedArray2/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js/WeakSet
  $ cat > ./melange/Js/WeakSet/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js/Fn
  $ cat > ./melange/Js/Fn/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt/Set/String
  $ cat > ./melange/Belt/Set/String/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt/Map/Dict
  $ cat > ./melange/Belt/Map/Dict/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt/SortArray/Int
  $ cat > ./melange/Belt/SortArray/Int/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt/SortArray/Int
  $ cat > ./melange/Belt/SortArray/Int/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Melange_ppx/Ast_literal
  $ cat > ./melange/Melange_ppx/Ast_literal/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Melange_ppx/External
  $ cat > ./melange/Melange_ppx/External/index.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat ./melange/Js/Global/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Js/Global/index.html" /></head>

  $ cat ./melange/Node/Foo/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Node/Foo/index.html" /></head>

  $ cat ./melange/Dom/Storage2/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Dom/Storage2/index.html" /></head>

  $ cat ./melange/Belt/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Belt/index.html" /></head>

  $ cat ./melange/Belt/List/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Belt/List/index.html" /></head>

  $ cat ./melange/Stdlib/Int/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Stdlib/Int/index.html" /></head>

  $ cat ./melange/Js/Typed_array/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Js/Typed_array/index.html" /></head>

  $ cat ./melange/Js/TypedArray2/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Js/TypedArray2/index.html" /></head>

  $ cat ./melange/Js/WeakSet/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Js/WeakSet/index.html" /></head>

  $ cat ./melange/Js/Fn/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Js/Fn/index.html" /></head>

  $ cat ./melange/Belt/Set/String/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Belt/Set/String/index.html" /></head>

  $ cat ./melange/Belt/Map/Dict/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Belt/Map/Dict/index.html" /></head>

  $ cat ./melange/Belt/SortArray/Int/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Belt/SortArray/Int/index.html" /></head>

  $ cat ./melange/Melange_ppx/Ast_literal/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Melange_ppx/Ast_literal/index.html" /></head>

  $ cat ./melange/Melange_ppx/External/index.html
  <head><link rel="canonical" href="https://melange.re/v3.0.0/api/melange/Melange_ppx/External/index.html" /></head>
