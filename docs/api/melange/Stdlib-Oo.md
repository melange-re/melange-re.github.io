
# Module `Stdlib.Oo`

Operations on objects

```
val copy : < .. > as 'a -> 'a
```
`Oo.copy o` returns a copy of object `o`, that is a fresh object with the same methods and instance variables as `o`.

alert unsynchronized\_access Unsynchronized accesses to mutable objects are a programming error.
```
val id : < .. > -> int
```
Return an integer identifying this object, unique for the current execution of the program. The generic comparison and hashing functions are based on this integer. When an object is obtained by unmarshaling, the id is refreshed, and thus different from the original object. As a consequence, the internal invariants of data structures such as hash table or sets containing objects are broken after unmarshaling the data structures.
