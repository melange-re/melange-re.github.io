Test add_canonical exe

  $ cat >foo.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat foo.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/foo.html" /></head>


  $ mkdir -p melange/Js_global
  $ cat > ./melange/Js_global/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Node_foo
  $ cat > ./melange/Node_foo/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Dom_storage2
  $ cat > ./melange/Dom_storage2/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt
  $ cat > ./melange/Belt/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt_List
  $ cat > ./melange/Belt_List/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Stdlib/Int
  $ cat > ./melange/Stdlib/Int/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js_typed_array
  $ cat > ./melange/Js_typed_array/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js_typed_array2
  $ cat > ./melange/Js_typed_array2/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Js_weakset
  $ cat > ./melange/Js_weakset/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt_SetString
  $ cat > ./melange/Belt_SetString/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt_MapDict
  $ cat > ./melange/Belt_MapDict/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Belt_SortArrayInt
  $ cat > ./melange/Belt_SortArrayInt/index.html  <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Melange_ppx/Private
  $ cat > ./melange/Melange_ppx/Private/index.html <<EOF
  > <head></head>
  > EOF

  $ mkdir -p melange/Melange_ppx/External
  $ cat > ./melange/Melange_ppx/External/index.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat ./melange/Js_global/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Js/Global/index.html" /></head>

  $ cat ./melange/Node_foo/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Node/Foo/index.html" /></head>

  $ cat ./melange/Dom_storage2/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Dom/Storage2/index.html" /></head>

  $ cat ./melange/Belt/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Belt/index.html" /></head>

  $ cat ./melange/Belt_List/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Belt/List/index.html" /></head>

  $ cat ./melange/Stdlib/Int/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Stdlib/Int/index.html" /></head>

  $ cat ./melange/Js_typed_array/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Js/Typed_array/index.html" /></head>

  $ cat ./melange/Js_typed_array2/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Js/TypedArray2/index.html" /></head>

  $ cat ./melange/Js_weakset/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Js/WeakSet/index.html" /></head>

  $ cat ./melange/Belt_SetString/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Belt/Set/String/index.html" /></head>

  $ cat ./melange/Belt_MapDict/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Belt/Map/Dict/index.html" /></head>

  $ cat ./melange/Belt_SortArrayInt/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Belt/SortArray/Int/index.html" /></head>

  $ cat ./melange/Melange_ppx/Private/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Melange_ppx/Private/index.html" /></head>

  $ cat ./melange/Melange_ppx/External/index.html
  <head><link rel="canonical" href="https://melange.re/v2.0.0/api/melange/Melange_ppx/External/index.html" /></head>
