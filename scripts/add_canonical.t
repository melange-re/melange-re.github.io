Test add_canonical exe

  $ cat >foo.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat foo.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/foo.html" /></head>

  $ mkdir -p melange/Js/Global melange/Node/Foo melange/Dom/Storage2 melange/Belt/List

  $ cat > ./melange/Js/Global/index.html <<EOF
  > <head></head>
  > EOF

  $ cat > ./melange/Node/Foo/index.html <<EOF
  > <head></head>
  > EOF

  $ cat > ./melange/Dom/Storage2/index.html <<EOF
  > <head></head>
  > EOF

  $ cat > ./melange/Belt/List/index.html <<EOF
  > <head></head>
  > EOF

  $ add_canonical .

  $ cat ./melange/Js/Global/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Js_global/index.html" /></head>

  $ cat ./melange/Node/Foo/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Node_foo/index.html" /></head>

  $ cat ./melange/Dom/Storage2/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Dom_storage2/index.html" /></head>

  $ cat ./melange/Belt/List/index.html
  <head><link rel="canonical" href="https://melange.re/v1.0.0/api/melange/Belt_list/index.html" /></head>
