# Melange for React Developers

## Motivation

This is a project-based, guided introduction to Melange and its ecosystem.
Because Melange uses both OCaml and JavaScript ecosystems, there are quite a few
tools and concepts to learn. Therefore we try to make each chapter small and
digestible, not introducing too many things at once.

## Audience

You should already know how to make frontend applications in JavaScript, in
particular with [React](https://react.dev/). You should be interested in
learning how to leverage your existing knowledge to build apps using
[ReasonReact](https://reasonml.github.io/reason-react/). You do not need to know
OCaml[^1]--we'll slowly introduce the basics of the language throughout the
tutorial. That said, a good complement to this guide is [OCaml Programming:
Correct + Efficient + Beautiful](https://cs3110.github.io/textbook/), which
teaches the language from the ground up and goes much deeper into its features.

## Chapters and topics

| Title  | Summary | Topics covered |
| ------ | ------- | -------------- |
| Counter | Number that can be incremented or decremented | modules, option, pipe last operator, switch |
| Melange Playground | Use Melange Playground to explore OCaml’s numeric types | playground, Int, Float |
| Celsius Converter | Single input that converts from  Celsius to Fahrenheit | exception handling, option, pattern matching, props |

...and much more to come!

[^1]:
    Because of the focus on ReasonReact, we won't cover traditional OCaml
    syntax in this guide. Instead, we'll cover the [Reason
    syntax](https://reasonml.github.io/) which works great with ReasonReact
    because of its first-class support for JSX.
