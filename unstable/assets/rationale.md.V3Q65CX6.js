import{_ as e,c as a,o as t,V as o}from"./chunks/framework.BCxdY_ip.js";const g=JSON.parse('{"title":"Why Melange","description":"","frontmatter":{},"headers":[],"relativePath":"rationale.md","filePath":"rationale.md"}'),r={name:"rationale.md"},i=o('<h1 id="why-melange" tabindex="-1">Why Melange <a class="header-anchor" href="#why-melange" aria-label="Permalink to &quot;Why Melange&quot;">​</a></h1><p>OCaml offers an industrial-strength, state-of-the-art type system and provides type inference with very few type annotations, proving invaluable in managing large projects.</p><p>JavaScript is one of the most pervasive platforms to deploy and run software. Thanks to years of efforts to improve the different VMs available, the JavaScript code running on browsers and other environments is heavily optimized and can support use cases for large products and tools.</p><p>Melange helps developers and companies bring the advantages of the OCaml platform to users of the Web platform in a way that makes it easy for developers to integrate with both ecosystems.</p><h2 id="a-bit-of-history" tabindex="-1">A bit of history <a class="header-anchor" href="#a-bit-of-history" aria-label="Permalink to &quot;A bit of history&quot;">​</a></h2><p>To better understand where Melange comes from, it might help to go through some of the related projects that have appeared over the last decade or so.</p><h3 id="js-of-ocaml" tabindex="-1">Js_of_ocaml <a class="header-anchor" href="#js-of-ocaml" aria-label="Permalink to &quot;Js\\_of\\_ocaml&quot;">​</a></h3><p><a href="https://github.com/ocsigen/js_of_ocaml/" target="_blank" rel="noreferrer">Js_of_ocaml</a> is another OCaml to JavaScript compiler that was made public in 2011. In <a href="https://www.irif.fr/~vouillon/publi/js_of_ocaml.pdf" target="_blank" rel="noreferrer">the presentation paper</a> published in 2013, it is explicitly mentioned that one of its design goals was to remain as compatible as possible with the OCaml compiler, without requiring a lot of maintenance work, as the OCaml community was not excessively large at the time.</p><p>To achieve this goal, Js_of_ocaml picks the bytecode generated by OCaml <a href="https://ocaml.org/manual/comp.html" target="_blank" rel="noreferrer">batch compilation</a> and generates JavaScript from it. OCaml bytecode has a very stable interface, so Js_of_ocaml can easily upgrade to new versions of the compiler. Due to this design decision, it can also remain compatible with most of the OCaml ecosystem, as long as the tools or libraries don’t rely on C code.</p><p>The downside of using bytecode is that it gets harder to communicate with existing JavaScript code. This is due to both the constraints on runtime representations that Js_of_ocaml can use for OCaml values, and also the compilation model used, where one bytecode program is compiled to one JavaScript program, but it is not possible to generate an individual JavaScript module from one OCaml module.</p><p>Another downside is that the resulting JavaScript is hard to read, as it is converted from a low-level representation like bytecode.</p><h3 id="bucklescript" tabindex="-1">BuckleScript <a class="header-anchor" href="#bucklescript" aria-label="Permalink to &quot;BuckleScript&quot;">​</a></h3><p>Then, in 2016, Bob Zhang suggests <a href="https://github.com/ocsigen/Js_of_ocaml/issues/338" target="_blank" rel="noreferrer">on a Js_of_ocaml repository issue</a> the possibility to start converting to JavaScript from an earlier stage of the compilation process, instead of using bytecode. This proposal fundamentally diverges from Js_of_ocaml original design and goals, so he starts working on what will become BuckleScript.</p><p>BuckleScript gets some inspiration from Js_of_ocaml, for example in the way that JavaScript objects are represented with <code>Js.t</code>. But it differs from Js_of_ocaml in many ways: it can generate more readable and lighter code. It also generates one <code>.js</code> file per module, which makes it easier to integrate with existing JavaScript codebases. BuckleScript puts a big emphasis on communicating with JavaScript code through a rich collection of attributes applied to <code>external</code> primitives.</p><h3 id="reason" tabindex="-1">Reason <a class="header-anchor" href="#reason" aria-label="Permalink to &quot;Reason&quot;">​</a></h3><p>Around the same year, a project called <a href="https://reasonml.github.io/" target="_blank" rel="noreferrer">Reason</a> appears at Facebook. Led by Jordan Walke, the idea is to create an alternate syntax for OCaml that is closer to C and JavaScript. Even if Reason has no take on which platform the code is deployed —native applications binaries, or web applications using JavaScript as a target language—, BuckleScript adds first class support for Reason from early on. At that point, it becomes evident that the combination of Reason with BuckleScript is a great match: BuckleScript provides tools and infrastructure to work with JavaScript ecosystem, while Reason allows developers to write their programs in a syntax they are familiar with.</p><p>Over time, and with help of other Facebook employees and the community providing bindings to pervasive JavaScript libraries like React.js with <a href="https://github.com/reasonml/reason-react/" target="_blank" rel="noreferrer"><code>reason-react</code></a>, the combination of Reason and BuckleScript gains adoption.</p><h3 id="bucklescript-gets-rebranded" tabindex="-1">BuckleScript gets rebranded <a class="header-anchor" href="#bucklescript-gets-rebranded" aria-label="Permalink to &quot;BuckleScript gets rebranded&quot;">​</a></h3><p>However, at some point the goals of both BuckleScript and Reason projects become harder to reconcile. In August 2020, the BuckleScript team decides to rename to ReScript, stops adding support for the latest versions of the Reason parser, and replaces it with a new parser that changes the syntax. The reasons for the rebranding are explained in <a href="https://rescript-lang.org/blog/bucklescript-is-rebranding" target="_blank" rel="noreferrer">the official ReScript blog post</a>.</p><p>The rebranding is trying to ease onboarding and adoption of the ReScript language, giving the project more chances to compete with mainstream compiled-to-JavaScript languages like TypeScript. However, for many existing users of BuckleScript and Reason, it is the explicit confirmation of something that had been hinted implicitly before: ReScript goals are not compatible with providing a good integration with the OCaml ecosystem.</p><h3 id="melange-back-to-ocaml" tabindex="-1">Melange: back to OCaml <a class="header-anchor" href="#melange-back-to-ocaml" aria-label="Permalink to &quot;Melange: back to OCaml&quot;">​</a></h3><p>This is where Melange comes in. A few weeks after the rebranding of BuckleScript to ReScript, António Monteiro starts working on a fork of BuckleScript with a simple (not easy) goal: replace the <a href="https://ninja-build.org/" target="_blank" rel="noreferrer">Ninja build system</a>, which BuckleScript had been using from its creation, with <a href="https://dune.build/" target="_blank" rel="noreferrer">Dune</a>, which is the most used build system for OCaml projects.</p><p>This fork of BuckleScript is later named Melange. After finishing the switch from Ninja to Dune, several additional features are added to bring it closer to OCaml. Some examples are the upgrade of the OCaml compiler version used by Melange, or modeling the changes to the OCaml compiler that Melange uses as just a plain library, instead of a full fork of the upstream compiler.</p><p>In September 2022, Ahrefs decides to invest on Melange by funding a project to deepen the integration between Dune and Melange. This project achieves its completion in Spring 2023, with the <a href="https://tech.ahrefs.com/ahrefs-is-now-built-with-melange-b14f5ec56df4" target="_blank" rel="noreferrer">migration of Ahrefs frontend codebase to Melange</a> and the new public releases that support it: version 3.8 of Dune and 1.0 of Melange.</p><h2 id="looking-forward" tabindex="-1">Looking forward <a class="header-anchor" href="#looking-forward" aria-label="Permalink to &quot;Looking forward&quot;">​</a></h2><p>While reaching v1.0 marks a major milestone for Melange, it is only the beginning of the journey. The Melange team remains committed to continuously improving Melange, ensuring it remains a robust and efficient tool for OCaml developers targeting the JavaScript platform. The <a href="./roadmap.html">roadmap</a> page details past work and current goals of Melange.</p>',26),n=[i];function s(l,c,h,p,d,m){return t(),a("div",null,n)}const u=e(r,[["render",s]]);export{g as __pageData,u as default};