# Module `Js.String`
Bindings to the functions in `String.prototype`
JavaScript String API
```
type t = string
```
```
val make : 'a -> t
```
`make value` converts the given value to a string
```ocaml
  make 3.5 = "3.5";;
  make [|1;2;3|]) = "1,2,3";;
```
```
val fromCharCode : int -> t
```
`fromCharCode n` creates a string containing the character corresponding to that number; *n* ranges from 0 to 65535. If out of range, the lower 16 bits of the value are used. Thus, `fromCharCode 0x1F63A` gives the same result as `fromCharCode 0xF63A`.
```ocaml
  fromCharCode 65 = "A";;
  fromCharCode 0x3c8 = {js|ψ|js};;
  fromCharCode 0xd55c = {js|한|js};;
  fromCharCode -64568 = {js|ψ|js};;
```
```
val fromCharCodeMany : int array -> t
```
`fromCharCodeMany [|n1;n2;n3|]` creates a string from the characters corresponding to the given numbers, using the same rules as `fromCharCode`.
```ocaml
  fromCharCodeMany([|0xd55c, 0xae00, 33|]) = {js|한글!|js};;
```
```
val fromCodePoint : int -> t
```
`fromCodePoint n` creates a string containing the character corresponding to that numeric code point. If the number is not a valid code point, **raises** `RangeError`. Thus, `fromCodePoint 0x1F63A` will produce a correct value, unlike `fromCharCode 0x1F63A`, and `fromCodePoint -5` will raise a `RangeError`.
```ocaml
  fromCodePoint 65 = "A";;
  fromCodePoint 0x3c8 = {js|ψ|js};;
  fromCodePoint 0xd55c = {js|한|js};;
  fromCodePoint 0x1f63a = {js|😺|js};;
```
```
val fromCodePointMany : int array -> t
```
`fromCharCodeMany [|n1;n2;n3|]` creates a string from the characters corresponding to the given code point numbers, using the same rules as `fromCodePoint`.
```ocaml
  fromCodePointMany([|0xd55c; 0xae00; 0x1f63a|]) = {js|한글😺|js}
```
```
val length : t -> int
```
`length s` returns the length of the given string.
```ocaml
  length "abcd" = 4;;
```
```
val get : t -> int -> t
```
`get s n` returns as a string the character at the given index number. If `n` is out of range, this function returns `undefined`, so at some point this function may be modified to return `t option`.
```ocaml
  get "Reason" 0 = "R";;
  get "Reason" 4 = "o";;
  get {js|Rẽasöń|js} 5 = {js|ń|js};;
```
```
val charAt : index:int -> t -> t
```
`charAt ~index s` gets the character at position `index` within string `s`. If `index` is negative or greater than the length of `s`, returns the empty string. If the string contains characters outside the range `\u0000-\uffff`, it will return the first 16-bit value at that position in the string.
```ocaml
  charAt ~index:0 "Reason" = "R"
  charAt ~index:12 "Reason" = "";
  charAt ~index:5 {js|Rẽasöń|js} = {js|ń|js}
```
```
val charCodeAt : index:int -> t -> float
```
`charCodeAt s ~index` returns the character code at position `index` in string `s`; the result is in the range 0-65535, unlke `codePointAt`, so it will not work correctly for characters with code points greater than or equal to `0x10000`. The return type is `float` because this function returns `NaN` if `index` is less than zero or greater than the length of the string.
```ocaml
  charCodeAt ~index:0 {js|😺|js} = 0xd83d
  codePointAt ~index:0 {js|😺|js} = Some 0x1f63a
```
```
val codePointAt : index:int -> t -> int option
```
`codePointAt s ~index` returns the code point at position `index` within string `s` as a `Some` value. The return value handles code points greater than or equal to `0x10000`. If there is no code point at the given position, the function returns `None`.
```ocaml
  codePointAt ~index:1 {js|¿😺?|js} = Some 0x1f63a
  codePointAt ~index:5 "abc" = None
```
ES2015
```
val concat : other:t -> t -> t
```
`concat ~other:str2 str1` returns a new string with `str2` added after `str1`.
```ocaml
  concat ~other:"bell" "cow" = "cowbell";;
```
```
val concatMany : strings:t array -> t -> t
```
`concatMany ~strings original` returns a new string consisting of each item of the array of strings `strings` added to the `original` string.
```ocaml
  concatMany ~strings:[|"2nd"; "3rd"; "4th"|] "1st" = "1st2nd3rd4th";;
```
```
val endsWith : suffix:t -> ?len:int -> t -> bool
```
`endsWith ~suffix ?len str` returns `true` if the `str` ends with `suffix`, `false` otherwise. If `len` is specified, \`endsWith\` only takes into account the first `len` characters.
```ocaml
  endsWith ~suffix:"cd" ~len:4 "abcd" = true;;
  endsWith ~suffix:"cd" ~len:3 "abcde" = false;;
  endsWith ~suffix:"cde" ~len:99 "abcde" = true;;
  endsWith ~suffix:"ple" ~len:7 "example.dat" = true;;
  endsWith ~suffix:"World!" "Hello, World!" = true;;
  endsWith ~suffix:"world!" "Hello, World!" = false;; (* case-sensitive *)
  endsWith ~suffix:"World" "Hello, World!" = false;; (* exact match *)
```
```
val includes : search:t -> ?start:int -> t -> bool
```
`includes ~search ?start s` returns `true` if `search` is found anywhere within `s` starting at character number `start` (where 0 is the first character), `false` otherwise.
```ocaml
  includes ~search:"gram" "programmer" = true;;
  includes ~search:"er" "programmer" = true;;
  includes ~search:"pro" "programmer" = true;;
  includes ~search:"xyz" "programmer" = false;;
  includes ~search:"gram" ~start:1 "programmer" = true;;
  includes ~search:"gram" ~start:4 "programmer" = false;;
  includes ~search:{js|한|js} ~start:1 {js|대한민국|js} = true;;
```
```
val indexOf : search:t -> ?start:int -> t -> int
```
`indexOf ~search ?start s` returns the position at which `search` was found within `s` starting at character position `start`, or `-1` if `search` is not found in that portion of `s`. The return value is relative to the beginning of the string, no matter where the search started from.
```ocaml
  indexOf ~search:"ok" "bookseller" = 2;;
  indexOf ~search:"sell" "bookseller" = 4;;
  indexOf ~search:"ee" "beekeeper" = 1;;
  indexOf ~search:"xyz" "bookseller" = -1;;
  indexOf ~search:"ok" ~start:1 "bookseller" = 2;;
  indexOf ~search:"sell" ~start:2 "bookseller" = 4;;
  indexOf ~search:"sell" ~start:5 "bookseller" = -1;;
```
```
val lastIndexOf : search:t -> ?start:int -> t -> int
```
`lastIndexOf ~search ~start s` returns the position of the *last* occurrence of `searchValue` within `s`, searching backwards from the given `start` position. Returns `-1` if `searchValue` is not in `s`. The return value is always relative to the beginning of the string.
```ocaml
  lastIndexOf ~search:"ok" "bookseller" = 2;;
  lastIndexOf ~search:"ee" "beekeeper" = 4;;
  lastIndexOf ~search:"xyz" "abcdefg" = -1;;
  lastIndexOf ~search:"ok" ~start:6 "bookseller" = 2;;
  lastIndexOf ~search:"ee" ~start:8 "beekeeper" = 4;;
  lastIndexOf ~search:"ee" ~start:3 "beekeeper" = 1;;
  lastIndexOf ~search:"xyz" ~start:4 "abcdefg" = -1;;
```
```
val localeCompare : other:t -> t -> float
```
`localeCompare ~other:comparison reference` returns:
- a negative value if `reference` comes before `comparison` in sort order
- zero if `reference` and `comparison` have the same sort order
- a positive value if `reference` comes after `comparison` in sort order
```ocaml
  (localeCompare ~other:"ant" "zebra") > 0.0;;
  (localeCompare ~other:"zebra" "ant") < 0.0;;
  (localeCompare ~other:"cat" "cat") = 0.0;;
  (localeCompare ~other:"cat" "CAT") > 0.0;;
```
```
val match_ : regexp:Js.re -> t -> t option array option
```
`match ~regexp str` matches a string against the given `regexp`. If there is no match, it returns `None`. For regular expressions without the `g` modifier, if there is a match, the return value is `Some array` where the array contains:
- The entire matched string
- Any capture groups if the `regexp` had parentheses
For regular expressions with the `g` modifier, a matched expression returns `Some array` with all the matched substrings and no capture groups.
```ocaml
  match "The better bats" ~regexp:[%re "/b[aeiou]t/"] = Some [|"bet"|]
  match "The better bats" ~regexp:[%re "/b[aeiou]t/g"] = Some [|"bet";"bat"|]
  match "Today is 2018-04-05." ~regexp:[%re "/(\\d+)-(\\d+)-(\\d+)/"] = Some [|"2018-04-05"; "2018"; "04"; "05"|]
  match "The large container." ~regexp:[%re "/b[aeiou]g/"] = None
```
```
val normalize : ?form:[ `NFC | `NFD | `NFKC | `NFKD ] -> t -> t
```
`normalize ~form str` returns the normalized Unicode string using the specified form of normalization, which may be one of:
- `` `NFC `` — Normalization Form Canonical Composition.
- `` `NFD `` — Normalization Form Canonical Decomposition.
- `` `NFKC `` — Normalization Form Compatibility Composition.
- `` `NFKD `` — Normalization Form Compatibility Decomposition.
If `form` is omitted, `` `NFC `` is used.
Consider the character `ã`, which can be represented as the single codepoint `\u00e3` or the combination of a lower case letter A `\u0061` and a combining tilde `\u0303`. Normalization ensures that both can be stored in an equivalent binary representation.
see [https://www.unicode.org/reports/tr15/tr15-45.html](https://www.unicode.org/reports/tr15/tr15-45.html) Unicode technical report for details
```
val repeat : count:int -> t -> t
```
`repeat ~count s` returns a string that consists of `count` repetitions of `s`. Raises `RangeError` if `n` is negative.
```ocaml
  repeat ~count:3 "ha" = "hahaha"
  repeat ~count:0 "empty" = ""
```
```
val replace : search:t -> replacement:t -> t -> t
```
`replace ~search ~replacement string` returns a new string which is identical to `string` except with the first matching instance of `search` replaced by `replacement`.
`search` is treated as a verbatim string to match, not a regular expression.
```ocaml
  replace ~search:"old" ~replacement:"new" "old string" = "new string"
  replace ~search:"the" ~replacement:"this" "the cat and the dog" = "this cat and the dog"
```
```
val replaceByRe : regexp:Js.re -> replacement:t -> t -> t
```
`replaceByRe ~regexp ~replacement string` returns a new string where occurrences matching `regexp` have been replaced by `replacement`.
```ocaml
  replaceByRe ~regexp:[%re "/[aeiou]/g"] ~replacement:"x" "vowels be gone" = "vxwxls bx gxnx"
  replaceByRe ~regexp:[%re "/(\\w+) (\\w+)/"] ~replacement:"$2, $1" "Juan Fulano" = "Fulano, Juan"
```
```
val unsafeReplaceBy0 : regexp:Js.re -> f:(t -> int -> t -> t) -> t -> t
```
`unsafeReplaceBy0 ~regexp ~f s` returns a new string with some or all matches of a pattern with no capturing parentheses replaced by the value returned from the given function. The function receives as its parameters the matched string, the offset at which the match begins, and the whole string being matched
```ocaml
let str = "beautiful vowels"
let re = [%re "/[aeiou]/g"]
let matchFn matchPart offset wholeString = Js.String.toUpperCase matchPart

let replaced = Js.String.unsafeReplaceBy0 ~regexp:re ~f:matchFn str

let () = Js.log replaced (* prints "bEAUtifUl vOwEls" *)
```
@see \<https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/replace\#Specifying\_a\_function\_as\_a\_parameter\> MDN
```
val unsafeReplaceBy1 : regexp:Js.re -> f:(t -> t -> int -> t -> t) -> t -> t
```
`unsafeReplaceBy1 ~regexp ~f s` returns a new string with some or all matches of a pattern with one set of capturing parentheses replaced by the value returned from the given function. The function receives as its parameters the matched string, the captured strings, the offset at which the match begins, and the whole string being matched.
```ocaml
let str = "increment 23"
let re = [%re "/increment (\\d+)/g"]
let matchFn matchPart p1 offset wholeString =
  wholeString ^ " is " ^ (string_of_int ((int_of_string p1) + 1))

let replaced = Js.String.unsafeReplaceBy1 ~regexp:re ~f:matchFn str

let () = Js.log replaced (* prints "increment 23 is 24" *)
```
@see \<https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/replace\#Specifying\_a\_function\_as\_a\_parameter\> MDN
```
val unsafeReplaceBy2 : 
  regexp:Js.re ->
  f:(t -> t -> t -> int -> t -> t) ->
  t ->
  t
```
`unsafeReplaceBy2 ~regexp ~f s` returns a new string with some or all matches of a pattern with two sets of capturing parentheses replaced by the value returned from the given function. The function receives as its parameters the matched string, the captured strings, the offset at which the match begins, and the whole string being matched.
```ocaml
let str = "7 times 6"
let re = [%re "/(\\d+) times (\\d+)/"]
let matchFn matchPart p1 p2 offset wholeString =
  string_of_int ((int_of_string p1) * (int_of_string p2))

let replaced = Js.String.unsafeReplaceBy2 ~regexp:re ~f:matchFn str

let () = Js.log replaced (* prints "42" *)
```
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/replace\#Specifying\_a\_function\_as\_a\_parameter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace#Specifying_a_function_as_a_parameter) MDN
```
val unsafeReplaceBy3 : 
  regexp:Js.re ->
  f:(t -> t -> t -> t -> int -> t -> t) ->
  t ->
  t
```
`unsafeReplaceBy3 ~regexp ~f s` returns a new string with some or all matches of a pattern with three sets of capturing parentheses replaced by the value returned from the given function. The function receives as its parameters the matched string, the captured strings, the offset at which the match begins, and the whole string being matched.
see [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/replace\#Specifying\_a\_function\_as\_a\_parameter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace#Specifying_a_function_as_a_parameter) MDN
```
val search : regexp:Js.re -> t -> int
```
`search ~regexp str` returns the starting position of the first match of `regexp` in the given `str`, or \-1 if there is no match.
```ocaml
search ~regexp:[%re "/\\d+/"] "testing 1 2 3" = 8;;
search ~regexp:[%re "/\\d+/"] "no numbers" = -1;;
```
```
val slice : ?start:int -> ?end_:int -> t -> t
```
`slice ?start ?end str` returns the substring of `str` starting at character `start` up to but not including `end`
If either `start` or `end` is negative, then it is evaluated as `length str - start` (or `length str - end`).
If `end` is greater than the length of `str`, then it is treated as `length str`.
If `start` is greater than `end`, `slice` returns the empty string.
```ocaml
  slice ~start:2 ~end_:5 "abcdefg" = "cde";;
  slice ~start:2 ~end_:9 "abcdefg" = "cdefg";;
  slice ~start:(-4) ~end_:(-2) "abcdefg" = "de";;
  slice ~start:5 ~end_:1 "abcdefg" = "";;
```
```
val split : ?sep:t -> ?limit:int -> t -> t array
```
`split ?sep ?limit str` splits the given `str` at every occurrence of `sep` and returns an array of the first `limit` resulting substrings. If `limit` is negative or greater than the number of substrings, the array will contain all the substrings.
```ocaml
  split ~sep:"/" ~limit: 3 "ant/bee/cat/dog/elk" = [|"ant"; "bee"; "cat"|];;
  split ~sep:"/" ~limit: 0 "ant/bee/cat/dog/elk" = [| |];;
  split ~sep:"/" ~limit: 9 "ant/bee/cat/dog/elk" = [|"ant"; "bee"; "cat"; "dog"; "elk"|];;
```
```
val splitByRe : regexp:Js.re -> ?limit:int -> t -> t option array
```
`splitByRe str ~regexp ?limit ()` splits the given `str` at every occurrence of `regexp` and returns an array of the first `limit` resulting substrings. If `limit` is negative or greater than the number of substrings, the array will contain all the substrings.
```ocaml
  splitByRe ~regexp:[%re "/\\s*:\\s*/"] ~limit:3 "one: two: three: four" = [|"one"; "two"; "three"|];;
  splitByRe ~regexp:[%re "/\\s*:\\s*/"] ~limit:0 "one: two: three: four" = [| |];;
  splitByRe ~regexp:[%re "/\\s*:\\s*/"] ~limit:8 "one: two: three: four" = [|"one"; "two"; "three"; "four"|];;
```
;
```
val startsWith : prefix:t -> ?start:int -> t -> bool
```
`startsWith ~prefix ?start str` returns `true` if the `str` starts with `prefix` starting at position `start`, `false` otherwise. If `start` is negative, the search starts at the beginning of `str`.
```ocaml
  startsWith ~prefix:"Hello" ~start:0 "Hello, World!" = true;;
  startsWith ~prefix:"World" ~start:7 "Hello, World!" = true;;
  startsWith ~prefix:"World" ~start:8 "Hello, World!" = false;;
```
```
val substr : ?start:int -> ?len:int -> t -> t
```
`substr ?start ?len str` returns the substring of `str` of length `len` starting at position `start`.
If `start` is less than zero, the starting position is the length of `str`
- `start`.
If `start` is greater than or equal to the length of `str`, returns the empty string.
If `len` is less than or equal to zero, returns the empty string.
```ocaml
  substr ~start:3 ~len:4 "abcdefghij" = "defghij"
  substr ~start:(-3) ~len:4 "abcdefghij" = "hij"
  substr ~start:12 ~len:2 "abcdefghij" = ""
```
deprecated This function is deprecated, see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/substr\#sect1
```
val substring : ?start:int -> ?end_:int -> t -> t
```
`substring ~start ~end_ str` returns characters `start` up to but not including `end_` from `str`.
If `start` is less than zero, it is treated as zero.
If `end_` is zero or negative, the empty string is returned.
If `start` is greater than `end_`, the start and finish points are swapped.
```ocaml
  substring ~start:3 ~end_:6 "playground" = "ygr";;
  substring ~start:6 ~end_:3 "playground" = "ygr";;
  substring ~start:4 ~end_:12 "playground" = "ground";;
```
```
val toLowerCase : t -> t
```
`toLowerCase str` converts `str` to lower case using the locale-insensitive case mappings in the Unicode Character Database. Notice that the conversion can give different results depending upon context, for example with the Greek letter sigma, which has two different lower case forms when it is the last character in a string or not.
```ocaml
  toLowerCase "ABC" = "abc";;
  toLowerCase {js|ΣΠ|js} = {js|σπ|js};;
  toLowerCase {js|ΠΣ|js} = {js|πς|js};;
```
```
val toLocaleLowerCase : t -> t
```
`toLocaleLowerCase str` converts `str` to lower case using the current locale
```
val toUpperCase : t -> t
```
`toUpperCase str` converts `str` to upper case using the locale-insensitive case mappings in the Unicode Character Database. Notice that the conversion can expand the number of letters in the result; for example the German `ß` capitalizes to two `S`es in a row.
```ocaml
  toUpperCase "abc" = "ABC";;
  toUpperCase {js|Straße|js} = {js|STRASSE|js};;
  toUpperCase {js|πς|js} = {js|ΠΣ|js};;
```
```
val toLocaleUpperCase : t -> t
```
`toLocaleUpperCase str` converts `str` to upper case using the current locale
```
val trim : t -> t
```
`trim str` returns a string that is `str` with whitespace stripped from both ends. Internal whitespace is not removed.
```ocaml
  trim "   abc def   " = "abc def"
  trim "\n\r\t abc def \n\n\t\r " = "abc def"
```
```
val anchor : name:t -> t -> t
```
`anchor ~name:anchorName anchorText` creates a string with an HTML `<a>` element with `name` attribute of `anchorName` and `anchorText` as its content.
```ocaml
  anchor ~name:"page1" "Page One" = "<a name=\"page1\">Page One</a>"
```
deprecated This function is deprecated, see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/anchor\#sect1
```
val link : href:t -> t -> t
```
`link ~href:urlText linkText` creates a string with an HTML `<a>` element with `href` attribute of `urlText` and `linkText` as its content.
```ocaml
  link ~href:"page2.html" "Go to page two" = "<a href=\"page2.html\">Go to page two</a>"
```
deprecated This function is deprecated, see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/String/link\#sect1
```
val unsafeToArrayLike : t -> t Js.array_like
```