Test add_canonical exe

  $ cat >foo.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat foo.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/foo.html" /></head>


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

  $ add_canonical .

  $ cat ./melange/Js/Global/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Js_global/index.html" /></head>

  $ cat ./melange/Node/Foo/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Node_foo/index.html" /></head>

  $ cat ./melange/Dom/Storage2/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Dom_storage2/index.html" /></head>

  $ cat ./melange/Belt/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Belt/index.html" /></head>

  $ cat ./melange/Belt/List/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Belt_list/index.html" /></head>

  $ cat ./melange/Stdlib/Int/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Stdlib/Int/index.html" /></head>
