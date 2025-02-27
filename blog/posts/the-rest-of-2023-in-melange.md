---
title: 'The rest of 2023 in Melange'
date: 2023-10-12
author: Antonio Monteiro
gravatar: 45c2052f50f561b9dc2cae59c777aecd794f57269fa317f9c9c3365c2e00d16f
twitter: '@_anmonteiro'
head:
  - - link
    - rel: canonical
      href: https://anmonteiro.substack.com/p/the-rest-of-2023-in-melange
---

As October 2023 unfolds, we'd like to present what we're planning to work on
during what remains of 2023. Built upon the invaluable feedback of our users and
our vision for Melange, we are excited about what's next.

---

![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F98530216-e8ed-478a-925e-e365ae5b2136_1792x1024.webp)

### Melange v3

By the close of Q4 2023, we're set to launch Melange v3. Here's a breakdown of
our main focus for shipping a new major release:

- **Fast, Reliable Builds**: We're fine-tuning Melange to ensure faster, more
  reliable project builds. This work is spread across a few fronts:

  - implementing some missing compiler and build system optimizations, improving
    the associated dune rules, and honing the underlying artifact representation
    for optimal performance.

  - improving the Melange core to be faster to build, run and evolve.

- **JavaScript Expressivity**:

  - we're aiming to make JavaScript idioms more intuitive in Melange. We're
    implementing more supported interoperability attributes, exploring new ways
    of writing bindings and surfacing their documentation and enriching the
    existing sections in the Melange docs.

  - we're planning on unifying the Melange core APIs around an abstraction over
    both [pipe
    operators](https://melange.re/v2.0.0/communicate-with-javascript/#pipe-operators) `|>` and `->`,
    allowing us to remove some modules where standard library duplication
    exists, ensuring a more consistent user experience, reducing confusion and
    evolvability of the code.

  - from supporting React 18 to introducing async component support, we're
    ensuring Melange stays up to date with the latest in React development. To
    make is easier to add these, we're planning to safely type JavaScript
    dynamic `import()`: this will make code more concise by removing the need
    for verbose workarounds but also ensures safety, reducing runtime errors

- **Development & Learning Experience**

  - With an emphasis on user-friendliness, we're improving the Melange
    Playground with a few requested features: by the end of the quarter it will
    offer advanced code diagnostics, bundle the new Melange
    v2 `melange.dom` library, present errors and warnings in a more robust way
    and test a new way of learning how to communicate with JavaScript from
    Melange.

  - Until the end of 2023, we're going to design and start implementing a whole
    new Melange website consolidated around a distinct, consistent brand.

  - We're planning to publish Melange for React Devs, a guided introduction for
    developers with existing React.js knowledge, bridging the gap between React
    and Melange, showcasing how some common React.js constructs are expressed in
    OCaml / Reason and Melange.

### The Melange Legacy

Having integrated with the OCaml Platform set of tools and ensured Melange
package availability in the OPAM repository, our previous releases have set the
stage for what's next: with Melange v3, we're striving for an even more robust,
expressive toolchain with an improved set of learning resources and an unmatched
in-browser learning experience on the Melange Playground.

The above is just a glimpse into what we're working on. Consult the [full
roadmap
document](https://docs.google.com/document/d/1q9NWiXun_Lqgv5iNNYm2SKzUGGJ02FpRawKUiTxnJPI/edit#heading=h.9je9ws3oydaz) for
more detail around what we'll be up to until the end of 2023.

Thank you for reading and happy hacking!
