
# Module `Stdlib.Sys`

System interface.

Every function in this module raises `Sys_error` with an informative message when the underlying system call signal an error.

```
val argv : string array
```
The command line arguments given to the process. The first element is the command name used to invoke the program. The following elements are the command-line arguments given to the program.

```
val executable_name : string
```
The name of the file containing the executable currently running. This name may be absolute or relative to the current directory, depending on the platform and whether the program was compiled to bytecode or a native executable.

```
val file_exists : string -> bool
```
Test if a file with the given name exists.

```
val is_directory : string -> bool
```
Returns `true` if the given name refers to a directory, `false` if it refers to another kind of file.

raises [`Sys_error`](./Stdlib.md#exception-Sys_error) if no file exists with the given name.
since 3.10
```
val is_regular_file : string -> bool
```
Returns `true` if the given name refers to a regular file, `false` if it refers to another kind of file.

raises [`Sys_error`](./Stdlib.md#exception-Sys_error) if no file exists with the given name.
since 5.1
```
val remove : string -> unit
```
Remove the given file name from the file system.

```
val rename : string -> string -> unit
```
Rename a file or directory. `rename oldpath newpath` renames the file or directory called `oldpath`, giving it `newpath` as its new name, moving it between (parent) directories if needed. If a file named `newpath` already exists, its contents will be replaced with those of `oldpath`. Depending on the operating system, the metadata (permissions, owner, etc) of `newpath` can either be preserved or be replaced by those of `oldpath`.

since 4.06 concerning the "replace existing file" behavior
```
val getenv : string -> string
```
Return the value associated to a variable in the process environment.

raises [`Not_found`](./Stdlib.md#exception-Not_found) if the variable is unbound.
```
val getenv_opt : string -> string option
```
Return the value associated to a variable in the process environment or `None` if the variable is unbound.

since 4.05
```
val command : string -> int
```
Execute the given shell command and return its exit code.

The argument of [`Sys.command`](./#val-command) is generally the name of a command followed by zero, one or several arguments, separated by whitespace. The given argument is interpreted by a shell: either the Windows shell `cmd.exe` for the Win32 ports of OCaml, or the POSIX shell `sh` for other ports. It can contain shell builtin commands such as `echo`, and also special characters such as file redirections `>` and `<`, which will be honored by the shell.

Conversely, whitespace or special shell characters occurring in command names or in their arguments must be quoted or escaped so that the shell does not interpret them. The quoting rules vary between the POSIX shell and the Windows shell. The [`Filename.quote_command`](./Stdlib-Filename.md#val-quote_command) performs the appropriate quoting given a command name, a list of arguments, and optional file redirections.

```
val time : unit -> float
```
Return the processor time, in seconds, used by the program since the beginning of execution.

```
val chdir : string -> unit
```
Change the current working directory of the process.

```
val mkdir : string -> int -> unit
```
Create a directory with the given permissions.

since 4.12
```
val rmdir : string -> unit
```
Remove an empty directory.

since 4.12
```
val getcwd : unit -> string
```
Return the current working directory of the process.

```
val readdir : string -> string array
```
Return the names of all files present in the given directory. Names denoting the current directory and the parent directory (`"."` and `".."` in Unix) are not returned. Each string in the result is a file name rather than a complete path. There is no guarantee that the name strings in the resulting array will appear in any specific order; they are not, in particular, guaranteed to appear in alphabetical order.

```
val interactive : bool ref
```
This reference is initially set to `false` in standalone programs and to `true` if the code is being executed under the interactive toplevel system `ocaml`.

alert unsynchronized\_access The interactive status is a mutable global state.
```
val os_type : string
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
```
| Other of string
```
```

```
Currently, the official distribution only supports `Native` and `Bytecode`, but it can be other backends with alternative compilers, for example, javascript.

since 4.04
```
val backend_type : backend_type
```
Backend type currently executing the OCaml program.

since 4.04
```
val unix : bool
```
True if `Sys.os_type = "Unix"`.

since 4.01
```
val win32 : bool
```
True if `Sys.os_type = "Win32"`.

since 4.01
```
val cygwin : bool
```
True if `Sys.os_type = "Cygwin"`.

since 4.01
```
val word_size : int
```
Size of one word on the machine currently executing the OCaml program, in bits: 32 or 64.

```
val int_size : int
```
Size of `int`, in bits. It is 31 (resp. 63) when using OCaml on a 32-bit (resp. 64-bit) platform. It may differ for other implementations, e.g. it can be 32 bits when compiling to JavaScript.

since 4.03
```
val big_endian : bool
```
Whether the machine currently executing the Caml program is big-endian.

since 4.00
```
val max_string_length : int
```
Maximum length of strings and byte sequences.

```
val max_array_length : int
```
Maximum length of a normal array (i.e. any array whose elements are not of type `float`). The maximum length of a `float array` is `max_floatarray_length` if OCaml was configured with `--enable-flat-float-array` and `max_array_length` if configured with `--disable-flat-float-array`.

```
val max_floatarray_length : int
```
Maximum length of a floatarray. This is also the maximum length of a `float array` when OCaml is configured with `--enable-flat-float-array`.

```
val runtime_variant : unit -> string
```
Return the name of the runtime variant the program is running on. This is normally the argument given to `-runtime-variant` at compile time, but for byte-code it can be changed after compilation.

since 4.03
```
val runtime_parameters : unit -> string
```
Return the value of the runtime parameters, in the same format as the contents of the `OCAMLRUNPARAM` environment variable.

since 4.03

## Signal handling

```
type signal_behavior = 
```
```
| Signal_default
```
```
| Signal_ignore
```
```
| Signal_handle of int -> unit
```
```

```
What to do when receiving a signal:

- `Signal_default`: take the default behavior (usually: abort the program)
- `Signal_ignore`: ignore the signal
- `Signal_handle f`: call function `f`, giving it the signal number as argument.
```
val signal : int -> signal_behavior -> signal_behavior
```
Set the behavior of the system on receipt of a given signal. The first argument is the signal number. Return the behavior previously associated with the signal. If the signal number is invalid (or not available on your system), an `Invalid_argument` exception is raised.

```
val set_signal : int -> signal_behavior -> unit
```
Same as [`Sys.signal`](./#val-signal) but return value is ignored.


### Signal numbers for the standard POSIX signals.

```
val sigabrt : int
```
Abnormal termination

```
val sigalrm : int
```
Timeout

```
val sigfpe : int
```
Arithmetic exception

```
val sighup : int
```
Hangup on controlling terminal

```
val sigill : int
```
Invalid hardware instruction

```
val sigint : int
```
Interactive interrupt (ctrl-C)

```
val sigkill : int
```
Termination (cannot be ignored)

```
val sigpipe : int
```
Broken pipe

```
val sigquit : int
```
Interactive termination

```
val sigsegv : int
```
Invalid memory reference

```
val sigterm : int
```
Termination

```
val sigusr1 : int
```
Application-defined signal 1

```
val sigusr2 : int
```
Application-defined signal 2

```
val sigchld : int
```
Child process terminated

```
val sigcont : int
```
Continue

```
val sigstop : int
```
Stop

```
val sigtstp : int
```
Interactive stop

```
val sigttin : int
```
Terminal read from background process

```
val sigttou : int
```
Terminal write from background process

```
val sigvtalrm : int
```
Timeout in virtual time

```
val sigprof : int
```
Profiling interrupt

```
val sigbus : int
```
Bus error

since 4.03
```
val sigpoll : int
```
Pollable event

since 4.03
```
val sigsys : int
```
Bad argument to routine

since 4.03
```
val sigtrap : int
```
Trace/breakpoint trap

since 4.03
```
val sigurg : int
```
Urgent condition on socket

since 4.03
```
val sigxcpu : int
```
Timeout in cpu time

since 4.03
```
val sigxfsz : int
```
File size limit exceeded

since 4.03
```
exception Break
```
Exception raised on interactive interrupt if [`Sys.catch_break`](./#val-catch_break) is enabled.

```
val catch_break : bool -> unit
```
`catch_break` governs whether interactive interrupt (ctrl-C) terminates the program or raises the `Break` exception. Call `catch_break true` to enable raising `Break`, and `catch_break false` to let the system terminate the program on user interrupt.

Inside multi-threaded programs, the `Break` exception will arise in any one of the active threads, and will keep arising on further interactive interrupt until all threads are terminated. Use signal masks from `Thread.sigmask` to direct the interrupt towards a specific thread.

```
val ocaml_version : string
```
`ocaml_version` is the version of OCaml. It is a string of the form `"major.minor[.patchlevel][(+|~)additional-info]"`, where `major`, `minor`, and `patchlevel` are integers, and `additional-info` is an arbitrary string. The `[.patchlevel]` part was absent before version 3.08.0 and became mandatory from 3.08.0 onwards. The `[(+|~)additional-info]` part may be absent.

```
val development_version : bool
```
`true` if this is a development version, `false` otherwise.

since 4.14
```
type extra_prefix = 
```
```
| Plus
```
```
| Tilde
```
since 4.14
```

```
```
type extra_info = extra_prefix * string
```
since 4.14
```
type ocaml_release_info = {
```
`major : int;`
`minor : int;`
`patchlevel : int;`
`extra : extra_info option;`
```
}
```
since 4.14
```
val ocaml_release : ocaml_release_info
```
`ocaml_release` is the version of OCaml.

since 4.14
```
val enable_runtime_warnings : bool -> unit
```
Control whether the OCaml runtime system can emit warnings on stderr. Currently, the only supported warning is triggered when a channel created by `open_*` functions is finalized without being closed. Runtime warnings are disabled by default.

since 4.03
alert unsynchronized\_access The status of runtime warnings is a mutable global state.
```
val runtime_warnings_enabled : unit -> bool
```
Return whether runtime warnings are currently enabled.

since 4.03
alert unsynchronized\_access The status of runtime warnings is a mutable global state.

## Optimization

```
val opaque_identity : 'a -> 'a
```
For the purposes of optimization, `opaque_identity` behaves like an unknown (and thus possibly side-effecting) function.

At runtime, `opaque_identity` disappears altogether. However, it does prevent the argument from being garbage collected until the location where the call would have occurred.

A typical use of this function is to prevent pure computations from being optimized away in benchmarking loops. For example:

```ocaml
  for _round = 1 to 100_000 do
    ignore (Sys.opaque_identity (my_pure_computation ()))
  done
```
since 4.03
```
module Immediate64 : sig ... end
```
This module allows to define a type `t` with the `immediate64` attribute. This attribute means that the type is immediate on 64 bit architectures. On other architectures, it might or might not be immediate.
