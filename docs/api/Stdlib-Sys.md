
# Module `Stdlib.Sys`

System interface.

Every function in this module raises `Sys_error` with an informative message when the underlying system call signal an error.

```ocaml
val argv : string array
```
```reasonml
let argv: array(string);
```
The command line arguments given to the process. The first element is the command name used to invoke the program. The following elements are the command-line arguments given to the program.

```ocaml
val executable_name : string
```
```reasonml
let executable_name: string;
```
The name of the file containing the executable currently running. This name may be absolute or relative to the current directory, depending on the platform and whether the program was compiled to bytecode or a native executable.

```ocaml
val file_exists : string -> bool
```
```reasonml
let file_exists: string => bool;
```
Test if a file with the given name exists.

```ocaml
val is_directory : string -> bool
```
```reasonml
let is_directory: string => bool;
```
Returns `true` if the given name refers to a directory, `false` if it refers to another kind of file.

raises [`Sys_error`](./Stdlib.md#exception-Sys_error) if no file exists with the given name.
since 3\.10
```ocaml
val is_regular_file : string -> bool
```
```reasonml
let is_regular_file: string => bool;
```
Returns `true` if the given name refers to a regular file, `false` if it refers to another kind of file.

raises [`Sys_error`](./Stdlib.md#exception-Sys_error) if no file exists with the given name.
since 5\.1
```ocaml
val remove : string -> unit
```
```reasonml
let remove: string => unit;
```
Remove the given file name from the file system.

```ocaml
val rename : string -> string -> unit
```
```reasonml
let rename: string => string => unit;
```
Rename a file or directory. `rename oldpath newpath` renames the file or directory called `oldpath`, giving it `newpath` as its new name, moving it between (parent) directories if needed. If a file named `newpath` already exists, its contents will be replaced with those of `oldpath`. Depending on the operating system, the metadata (permissions, owner, etc) of `newpath` can either be preserved or be replaced by those of `oldpath`.

since 4\.06 concerning the "replace existing file" behavior
```ocaml
val getenv : string -> string
```
```reasonml
let getenv: string => string;
```
Return the value associated to a variable in the process environment.

raises [`Not_found`](./Stdlib.md#exception-Not_found) if the variable is unbound.
```ocaml
val getenv_opt : string -> string option
```
```reasonml
let getenv_opt: string => option(string);
```
Return the value associated to a variable in the process environment or `None` if the variable is unbound.

since 4\.05
```ocaml
val command : string -> int
```
```reasonml
let command: string => int;
```
Execute the given shell command and return its exit code.

The argument of [`Sys.command`](./#val-command) is generally the name of a command followed by zero, one or several arguments, separated by whitespace. The given argument is interpreted by a shell: either the Windows shell `cmd.exe` for the Win32 ports of OCaml, or the POSIX shell `sh` for other ports. It can contain shell builtin commands such as `echo`, and also special characters such as file redirections `>` and `<`, which will be honored by the shell.

Conversely, whitespace or special shell characters occurring in command names or in their arguments must be quoted or escaped so that the shell does not interpret them. The quoting rules vary between the POSIX shell and the Windows shell. The [`Filename.quote_command`](./Stdlib-Filename.md#val-quote_command) performs the appropriate quoting given a command name, a list of arguments, and optional file redirections.

```ocaml
val time : unit -> float
```
```reasonml
let time: unit => float;
```
Return the processor time, in seconds, used by the program since the beginning of execution.

```ocaml
val chdir : string -> unit
```
```reasonml
let chdir: string => unit;
```
Change the current working directory of the process.

```ocaml
val mkdir : string -> int -> unit
```
```reasonml
let mkdir: string => int => unit;
```
Create a directory with the given permissions.

since 4\.12
```ocaml
val rmdir : string -> unit
```
```reasonml
let rmdir: string => unit;
```
Remove an empty directory.

since 4\.12
```ocaml
val getcwd : unit -> string
```
```reasonml
let getcwd: unit => string;
```
Return the current working directory of the process.

```ocaml
val readdir : string -> string array
```
```reasonml
let readdir: string => array(string);
```
Return the names of all files present in the given directory. Names denoting the current directory and the parent directory (`"."` and `".."` in Unix) are not returned. Each string in the result is a file name rather than a complete path. There is no guarantee that the name strings in the resulting array will appear in any specific order; they are not, in particular, guaranteed to appear in alphabetical order.

```ocaml
val io_buffer_size : int
```
```reasonml
let io_buffer_size: int;
```
Size of C buffers used by the runtime system and IO primitives of the `unix` library. Primitives that read from or write to values of type `string` or `bytes` generally use an intermediate buffer of this size to avoid holding the domain lock.

since 5\.4
```ocaml
val interactive : bool ref
```
```reasonml
let interactive: ref(bool);
```
This reference is initially set to `false` in standalone programs and to `true` if the code is being executed under the interactive toplevel system `ocaml`.

alert unsynchronized\_access The interactive status is a mutable global state.
```ocaml
val os_type : string
```
```reasonml
let os_type: string;
```
Operating system currently executing the OCaml program. One of

- `"Unix"` (for all Unix versions, including Linux and Mac OS X),
- `"Win32"` (for MS-Windows, OCaml compiled with MSVC++ or MinGW-w64),
- `"Cygwin"` (for MS-Windows, OCaml compiled with Cygwin).
```
type backend_type = 
```
```
| Native
```
```
| Bytecode
```
```ocaml
| Other of string
```
```reasonml
| Other(string)
```
```ocaml

```
```reasonml
;
```
Currently, the official distribution only supports `Native` and `Bytecode`, but it can be other backends with alternative compilers, for example, javascript.

since 4\.04
```ocaml
val backend_type : backend_type
```
```reasonml
let backend_type: backend_type;
```
Backend type currently executing the OCaml program.

since 4\.04
```ocaml
val unix : bool
```
```reasonml
let unix: bool;
```
True if `Sys.os_type = "Unix"`.

since 4\.01
```ocaml
val win32 : bool
```
```reasonml
let win32: bool;
```
True if `Sys.os_type = "Win32"`.

since 4\.01
```ocaml
val cygwin : bool
```
```reasonml
let cygwin: bool;
```
True if `Sys.os_type = "Cygwin"`.

since 4\.01
```ocaml
val word_size : int
```
```reasonml
let word_size: int;
```
Size of one word on the machine currently executing the OCaml program, in bits: 32 or 64\.

```ocaml
val int_size : int
```
```reasonml
let int_size: int;
```
Size of `int`, in bits. It is 31 (resp. 63\) when using OCaml on a 32-bit (resp. 64-bit) platform. It may differ for other implementations, e.g. it can be 32 bits when compiling to JavaScript.

since 4\.03
```ocaml
val big_endian : bool
```
```reasonml
let big_endian: bool;
```
Whether the machine currently executing the Caml program is big-endian.

since 4\.00
```ocaml
val max_string_length : int
```
```reasonml
let max_string_length: int;
```
Maximum length of strings and byte sequences.

```ocaml
val max_array_length : int
```
```reasonml
let max_array_length: int;
```
Maximum length of a normal array (i.e. any array whose elements are not of type `float`). The maximum length of a `float array` is `max_floatarray_length` if OCaml was configured with `--enable-flat-float-array` and `max_array_length` if configured with `--disable-flat-float-array`.

```ocaml
val max_floatarray_length : int
```
```reasonml
let max_floatarray_length: int;
```
Maximum length of a floatarray. This is also the maximum length of a `float array` when OCaml is configured with `--enable-flat-float-array`.

```ocaml
val runtime_variant : unit -> string
```
```reasonml
let runtime_variant: unit => string;
```
Return the name of the runtime variant the program is running on. This is normally the argument given to `-runtime-variant` at compile time, but for byte-code it can be changed after compilation.

since 4\.03
```ocaml
val runtime_parameters : unit -> string
```
```reasonml
let runtime_parameters: unit => string;
```
Return the value of the runtime parameters, in the same format as the contents of the `OCAMLRUNPARAM` environment variable.

since 4\.03

## Signal handling

```ocaml
type signal = int
```
```reasonml
type signal = int;
```
The type for signal numbers. Negative numbers are used by OCaml to provide a platform-independent number for signals recognised by OCaml. Positive numbers are always the platform-dependent value for a given signal. The function [`signal_of_int`](./#val-signal_of_int) converts known platform-dependent numbers to independent ones, and [`signal_to_int`](./#val-signal_to_int) does the reverse.

since 5\.4
```
type signal_behavior = 
```
```
| Signal_default
```
```
| Signal_ignore
```
```ocaml
| Signal_handle of signal -> unit
```
```reasonml
| Signal_handle(signal => unit)
```
```ocaml

```
```reasonml
;
```
What to do when receiving a signal:

- `Signal_default`: take the default behavior (usually: abort the program)
- `Signal_ignore`: ignore the signal
- `Signal_handle f`: call function `f`, giving it the signal number as an argument.
```ocaml
val signal : signal -> signal_behavior -> signal_behavior
```
```reasonml
let signal: signal => signal_behavior => signal_behavior;
```
Set the behavior of the system on receipt of a given signal. The first argument is the signal number. Return the behavior previously associated with the signal. If the signal number is invalid (or not available on your system), an `Invalid_argument` exception is raised. If a platform-dependent signal number is used, it will be converted to a platform-independent signal using [`signal_of_int`](./#val-signal_of_int) before calling the handler.

```ocaml
val set_signal : signal -> signal_behavior -> unit
```
```reasonml
let set_signal: signal => signal_behavior => unit;
```
Same as [`Sys.signal`](./#type-signal) but the return value is ignored.


### Signal numbers for the standard POSIX signals.

```ocaml
val sigabrt : signal
```
```reasonml
let sigabrt: signal;
```
Abnormal termination

```ocaml
val sigalrm : signal
```
```reasonml
let sigalrm: signal;
```
Timeout

```ocaml
val sigfpe : signal
```
```reasonml
let sigfpe: signal;
```
Arithmetic exception

```ocaml
val sighup : signal
```
```reasonml
let sighup: signal;
```
Hangup on controlling terminal

```ocaml
val sigill : signal
```
```reasonml
let sigill: signal;
```
Invalid hardware instruction

```ocaml
val sigint : signal
```
```reasonml
let sigint: signal;
```
Interactive interrupt (ctrl-C)

```ocaml
val sigkill : signal
```
```reasonml
let sigkill: signal;
```
Termination (cannot be ignored)

```ocaml
val sigpipe : signal
```
```reasonml
let sigpipe: signal;
```
Broken pipe

```ocaml
val sigquit : signal
```
```reasonml
let sigquit: signal;
```
Interactive termination

```ocaml
val sigsegv : signal
```
```reasonml
let sigsegv: signal;
```
Invalid memory reference

```ocaml
val sigterm : signal
```
```reasonml
let sigterm: signal;
```
Termination

```ocaml
val sigusr1 : signal
```
```reasonml
let sigusr1: signal;
```
Application-defined signal 1

```ocaml
val sigusr2 : signal
```
```reasonml
let sigusr2: signal;
```
Application-defined signal 2

```ocaml
val sigchld : signal
```
```reasonml
let sigchld: signal;
```
Child process terminated

```ocaml
val sigcont : signal
```
```reasonml
let sigcont: signal;
```
Continue

```ocaml
val sigstop : signal
```
```reasonml
let sigstop: signal;
```
Stop (cannot be caught or ignored)

```ocaml
val sigtstp : signal
```
```reasonml
let sigtstp: signal;
```
Interactive stop

```ocaml
val sigttin : signal
```
```reasonml
let sigttin: signal;
```
Terminal read from background process

```ocaml
val sigttou : signal
```
```reasonml
let sigttou: signal;
```
Terminal write from background process

```ocaml
val sigvtalrm : signal
```
```reasonml
let sigvtalrm: signal;
```
Timeout in virtual time

```ocaml
val sigprof : signal
```
```reasonml
let sigprof: signal;
```
Profiling interrupt

```ocaml
val sigbus : signal
```
```reasonml
let sigbus: signal;
```
Bus error

since 4\.03
```ocaml
val sigpoll : signal
```
```reasonml
let sigpoll: signal;
```
Pollable event

since 4\.03
```ocaml
val sigsys : signal
```
```reasonml
let sigsys: signal;
```
Bad argument to routine

since 4\.03
```ocaml
val sigtrap : signal
```
```reasonml
let sigtrap: signal;
```
Trace/breakpoint trap

since 4\.03
```ocaml
val sigurg : signal
```
```reasonml
let sigurg: signal;
```
Urgent condition on socket

since 4\.03
```ocaml
val sigxcpu : signal
```
```reasonml
let sigxcpu: signal;
```
Timeout in cpu time

since 4\.03
```ocaml
val sigxfsz : signal
```
```reasonml
let sigxfsz: signal;
```
File size limit exceeded

since 4\.03
```ocaml
val sigio : signal
```
```reasonml
let sigio: signal;
```
I/O is possible on a descriptor

since 5\.4
```ocaml
val sigwinch : signal
```
```reasonml
let sigwinch: signal;
```
Window size change

since 5\.4
```ocaml
val signal_to_string : signal -> string
```
```reasonml
let signal_to_string: signal => string;
```
`signal_to_string` formats an OCaml `signal` as a C POSIX [constant](http://pubs.opengroup.org/onlinepubs/9799919799/basedefs/signal.h.html) or `"SIG(%d)"` for platform-dependent signal numbers.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) for unrecognised negative numbers.
since 5\.4
```ocaml
val signal_of_int : int -> signal
```
```reasonml
let signal_of_int: int => signal;
```
`signal_of_int n` converts a platform-dependent signal number `n` to an OCaml signal number. For positive `n` this is `n` itself if OCaml does not have a platform-independent signal number for `n`.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) if n is negative.
since 5\.4
```ocaml
val signal_to_int : signal -> int
```
```reasonml
let signal_to_int: signal => int;
```
`signal_to_int n` converts an OCaml signal number `n` to a platform-dependent signal number. For positive `n` this is `n` itself.

raises [`Invalid_argument`](./Stdlib.md#exception-Invalid_argument) for unrecognised negative numbers.
since 5\.4
```ocaml
exception Break
```
```reasonml
exception Break;
```
Exception raised on interactive interrupt if [`Sys.catch_break`](./#val-catch_break) is enabled.

```ocaml
val catch_break : bool -> unit
```
```reasonml
let catch_break: bool => unit;
```
`catch_break` governs whether interactive interrupt (ctrl-C) terminates the program or raises the `Break` exception. Call `catch_break true` to enable raising `Break`, and `catch_break false` to let the system terminate the program on user interrupt.

Inside multi-threaded programs, the `Break` exception will arise in any one of the active threads, and will keep arising on further interactive interrupt until all threads are terminated. Use signal masks from `Thread.sigmask` to direct the interrupt towards a specific thread.

```ocaml
val ocaml_version : string
```
```reasonml
let ocaml_version: string;
```
`ocaml_version` is the version of OCaml. It is a string of the form `"major.minor[.patchlevel][(+|~)additional-info]"`, where `major`, `minor`, and `patchlevel` are integers, and `additional-info` is an arbitrary string. The `[.patchlevel]` part was absent before version 3\.08.0 and became mandatory from 3\.08.0 onwards. The `[(+|~)additional-info]` part may be absent.

```ocaml
val development_version : bool
```
```reasonml
let development_version: bool;
```
`true` if this is a development version, `false` otherwise.

since 4\.14
```
type extra_prefix = 
```
```
| Plus
```
```
| Tilde
```
since 4\.14
```ocaml

```
```reasonml
;
```
```ocaml
type extra_info = extra_prefix * string
```
```reasonml
type extra_info = (extra_prefix, string);
```
since 4\.14
```
type ocaml_release_info = {
```
`major : int;`
`minor : int;`
`patchlevel : int;`
`extra : extra_info option;`
```ocaml
}
```
```reasonml
};
```
since 4\.14
```ocaml
val ocaml_release : ocaml_release_info
```
```reasonml
let ocaml_release: ocaml_release_info;
```
`ocaml_release` is the version of OCaml.

since 4\.14
```ocaml
val enable_runtime_warnings : bool -> unit
```
```reasonml
let enable_runtime_warnings: bool => unit;
```
Control whether the OCaml runtime system can emit warnings on stderr. Currently, the only supported warning is triggered when a channel created by `open_*` functions is finalized without being closed. Runtime warnings are disabled by default.

since 4\.03
alert unsynchronized\_access The status of runtime warnings is a mutable global state.
```ocaml
val runtime_warnings_enabled : unit -> bool
```
```reasonml
let runtime_warnings_enabled: unit => bool;
```
Return whether runtime warnings are currently enabled.

since 4\.03
alert unsynchronized\_access The status of runtime warnings is a mutable global state.

## Optimization

```ocaml
val opaque_identity : 'a -> 'a
```
```reasonml
let opaque_identity: 'a => 'a;
```
For the purposes of optimization, `opaque_identity` behaves like an unknown (and thus possibly side-effecting) function.

At runtime, `opaque_identity` disappears altogether. However, it does prevent the argument from being garbage collected until the location where the call would have occurred.

A typical use of this function is to prevent pure computations from being optimized away in benchmarking loops. For example:

```ocaml
  for _round = 1 to 100_000 do
    ignore (Sys.opaque_identity (my_pure_computation ()))
  done
```
```reasonml
for (_round in 1 to 100_000) {
  ignore(Sys.opaque_identity(my_pure_computation()));
};
```
since 4\.03
```ocaml
module Immediate64 : sig ... end
```
```reasonml
module Immediate64: { ... };
```
This module allows to define a type `t` with the `immediate64` attribute. This attribute means that the type is immediate on 64 bit architectures. On other architectures, it might or might not be immediate.
