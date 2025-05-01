# Module `Gc.Memprof`
`Memprof` is a profiling engine which randomly samples allocated memory words. Every allocated word has a probability of being sampled equal to a configurable sampling rate. Once a block is sampled, it becomes tracked. A tracked block triggers a user-defined callback as soon as it is allocated, promoted or deallocated.
Since blocks are composed of several words, a block can potentially be sampled several times. If a block is sampled several times, then each of the callbacks is called once for each event of this block: the multiplicity is given in the `n_samples` field of the `allocation` structure.
This engine makes it possible to implement a low-overhead memory profiler as an OCaml library.
Note: this API is EXPERIMENTAL. It may change without prior notice.
```
type t
```
the type of a profile
```
type allocation_source = 
```
```
| Normal
```
```
| Marshal
```
```
| Custom
```
```

```
```
type allocation = private {
```
`n_samples : int;`
The number of samples in this block (\>= 1\).
`size : int;`
The size of the block, in words, excluding the header.
`source : allocation_source;`
The cause of the allocation.
`callstack : Printexc.raw_backtrace;`
The callstack for the allocation.
```
}
```
The type of metadata associated with allocations. This is the type of records passed to the callback triggered by the sampling of an allocation.
```
type ('minor, 'major) tracker = {
```
`alloc_minor : allocation -> 'minor option;`
`alloc_major : allocation -> 'major option;`
`promote : 'minor -> 'major option;`
`dealloc_minor : 'minor -> unit;`
`dealloc_major : 'major -> unit;`
```
}
```
A `('minor, 'major) tracker` describes how memprof should track sampled blocks over their lifetime, keeping a user-defined piece of metadata for each of them: `'minor` is the type of metadata to keep for minor blocks, and `'major` the type of metadata for major blocks.
The member functions in a `tracker` are called callbacks.
If an allocation or promotion callback raises an exception or returns `None`, memprof stops tracking the corresponding block.
```
val null_tracker : ('minor, 'major) tracker
```
Default callbacks simply return `None` or `()`
```
val start : 
  sampling_rate:float ->
  ?callstack_size:int ->
  ('minor, 'major) tracker ->
  t
```
Start a profile with the given parameters. Raises an exception if a profile is already sampling in the current domain.
Sampling begins immediately. The parameter `sampling_rate` is the sampling rate in samples per word (including headers). Usually, with cheap callbacks, a rate of 1e-4 has no visible effect on performance, and 1e-3 causes the program to run a few percent slower. 0.0 \<= sampling\_rate \<= 1\.0.
The parameter `callstack_size` is the length of the callstack recorded at every sample. Its default is `max_int`.
The parameter `tracker` determines how to track sampled blocks over their lifetime in the minor and major heap.
Sampling and running callbacks are temporarily disabled on the current thread when calling a callback, so callbacks do not need to be re-entrant if the program is single-threaded and single-domain. However, if threads or multiple domains are used, it is possible that several callbacks will run in parallel. In this case, callback functions must be re-entrant.
Note that a callback may be postponed slightly after the actual event. The callstack passed to an allocation callback always accurately reflects the allocation, but the program state may have evolved between the allocation and the call to the callback.
If a new thread or domain is created when the current domain is sampling for a profile, the child thread or domain joins that profile (using the same `sampling_rate`, `callstack_size`, and `tracker` callbacks).
An allocation callback is always run by the thread which allocated the block. If the thread exits or the profile is stopped before the callback is called, the allocation callback is not called and the block is not tracked.
Each subsequent callback is generally run by the domain which allocated the block. If the domain terminates or the profile is stopped before the callback is called, the callback may be run by a different domain.
Different domains may sample for different profiles simultaneously.
```
val stop : unit -> unit
```
Stop sampling for the current profile. Fails if no profile is sampling in the current domain. Stops sampling in all threads and domains sharing the profile.
Promotion and deallocation callbacks from a profile may run after `stop` is called, until `discard` is applied to the profile.
A profile is implicitly stopped (but not discarded) if all domains and threads sampling for it are terminated.
```
val discard : t -> unit
```
Discards all profiling state for a stopped profile, which prevents any more callbacks for it. Raises an exception if called on a profile which has not been stopped.