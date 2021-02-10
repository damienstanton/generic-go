What are generics?
---

> The "generic programming" paradigm is an approach to software decomposition whereby fundamental requirements on types are abstracted from across concrete examples of algorithms and data structures and formalized as concepts, analogously to the abstraction of algebraic theories in abstract algebra.

_Elements of Programming, Stepanov & McJones 2009_

Go interfaces as a set abstraction
---

![](https://f001.backblazeb2.com/file/dks-public/interface.png)

Takeaways
---

- Functions can have an additional type parameter list that uses square brackets but otherwise looks like an ordinary parameter list: `func F[T any](p T) { ... }`.
- These type parameters can be used by the regular parameters and in the function body.
- Types can also have a type parameter list: `type M[T any] []T`.
- Each type parameter has a type constraint, just as each ordinary parameter has a type: `func F[T Constraint](p T) { ... }`.
- Type constraints are interface types.
- The new predeclared name `any` is a type constraint that permits any type.
- The new predeclared name `comparable` permits the use of == and != with values of that type parameter.
- Interface types used as type constraints can have a list of predeclared types; only type arguments that match one of those types satisfy the constraint.
- Generic functions may only use operations permitted by the type constraint.
- Using a generic function or type requires passing type arguments.
- Type inference permits omitting the type arguments of a function call in common cases.

Helpful Links
---

- [The wikipedia entry on generics (actually quite good)][3]
- [The full Go generics draft design document by Ian Lance Taylor and Robert Griesemer][1]
- [The `go2go` playground online][2]
- Installing the `go2go` branch on your local machine: Follow the steps listed [here][4], but checkout the branch `dev.go2go`
- Phil Wadler's [paper][5] and a [Zoom talk][6] on "Featherweight Go", the theoretical basis for generics in Go

Comparison to other languages
---

## ☕ Java

Most complaints about Java generics center around type erasure. This design does not have type erasure. The reflection information for a generic type will include the full compile-time type information. In Java type wildcards (List<? extends Number>, List<? super Number>) implement covariance and contravariance. These concepts are missing from Go, which makes generic types much simpler.

## 🔨 C++

C++ templates do not enforce any constraints on the type arguments (unless the concept proposal is adopted). This means that changing template code can accidentally break far-off instantiations. It also means that error messages are reported only at instantiation time, and can be deeply nested and difficult to understand. This design avoids these problems through mandatory and explicit constraints. C++ supports template metaprogramming, which can be thought of as ordinary programming done at compile time using a syntax that is completely different than that of non-template C++. This design has no similar feature. This saves considerable complexity while losing some power and run time efficiency. C++ uses two-phase name lookup, in which some names are looked up in the context of the template definition, and some names are looked up in the context of the template instantiation. In this design all names are looked up at the point where they are written. In practice, all C++ compilers compile each template at the point where it is instantiated. This can slow down compilation time. This design offers flexibility as to how to handle the compilation of generic functions.

## 🦀 Rust
The generics described in this design are similar to generics in Rust. One difference is that in Rust the association between a trait bound and a type must be defined explicitly, either in the crate that defines the trait bound or the crate that defines the type. In Go terms, this would mean that we would have to declare somewhere whether a type satisfied a constraint. Just as Go types can satisfy Go interfaces without an explicit declaration, in this design Go type arguments can satisfy a constraint without an explicit declaration. Where this design uses type lists, the Rust standard library defines standard traits for operations like comparison. These standard traits are automatically implemented by Rust's primitive types, and can be implemented by user defined types as well. Rust provides a fairly extensive list of traits, at least 34, covering all of the operators. Rust supports type parameters on methods, which this design does not.


[1]: https://go.googlesource.com/proposal/+/refs/heads/master/design/go2draft-type-parameters.md
[2]: https://go2goplay.golang.org/
[3]: https://en.wikipedia.org/wiki/Generic_programming
[4]: https://golang.org/doc/install/source
[5]: https://dl.acm.org/doi/pdf/10.1145/3428217
[6]: https://youtu.be/Dq0WFigax_c

© 2021 Damien Stanton

See LICENSE for details.

