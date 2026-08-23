> **Audience:** engineers · **Status:** current · **Owner:** agents

# Modularity

Where this project's seams are, and which expected change each one protects.

A **seam** is a place where behaviour can be changed without editing in that place. Seams are not
free — every one is indirection paid for on every read — so each exists for a named reason, recorded
here.

## On this page

- [Seams](#seams)
- [Deliberately not seamed](#deliberately-not-seamed)
- [Vocabulary](#vocabulary)
- [Tests applied here](#tests-applied-here)
- [Module notes](#module-notes)

## Seams

| Seam | Interface | Adapters today | The pivot it protects |
|---|---|---|---|
| {{name}} | `{{where the interface is defined}}` | {{what implements it}} | {{the change we expect, that this keeps to one place}} |

A row whose "pivot it protects" column is vague is a seam that should probably not exist. One
adapter is a hypothetical seam; two is a real one.

## Deliberately not seamed

{{Places where an abstraction would be the obvious move and we chose against it. Recording these
stops someone helpfully adding the indirection later.}}

- **{{thing}}** — {{why direct coupling is right here}}

## Vocabulary

Used exactly, so discussions are about the same thing.

- **Module** — anything with an interface and an implementation. A function, a class, a package, or
  a slice spanning tiers. *Not:* unit, component, service.
- **Interface** — everything a caller must know to use it correctly: the signature, and also the
  invariants, ordering constraints, error modes, required configuration, and performance
  characteristics.
- **Seam** — where a module's interface lives; the place behaviour can be swapped. *Not:* boundary.
- **Adapter** — a concrete thing satisfying an interface at a seam. A role, not a substance.
- **Deep** — a lot of behaviour behind a small interface. **Shallow** — an interface nearly as
  complex as what it hides. Aim deep.

## Tests applied here

- **Deletion test.** If deleting a module makes complexity vanish, it was a pass-through. If the
  same complexity reappears across its callers, it earned its keep.
- **Two adapters, or no seam.**
- **The interface is the test surface.** Wanting to test past an interface means the module is the
  wrong shape.
- **Pivot test.** Name the change you expect; if making it touches more than two or three places,
  a seam is missing where that change lands.

## Module notes

{{Per significant module: what it owns, what it deliberately does not, and anything a caller must
know that the type signature does not say.}}

### {{module}}

- **Owns:** {{...}}
- **Does not own:** {{...}}
- **Callers must know:** {{ordering constraints, error modes, performance characteristics}}
